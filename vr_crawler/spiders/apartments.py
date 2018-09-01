import scrapy

from vr_crawler.items import ApartmentLoader, AddressLoader


class ApartmentsSpider(scrapy.Spider):
    name = 'apartments'
    start_url = 'https://www.vivareal.com.br/aluguel/sp/sao-paulo/aapartamento_residencial/'
    custom_settings = {
        'ITEM_PIPELINES': {
            'vr_crawler.pipelines.ApartmentPipeline': 300
        },
    }

    def start_requests(self):
        return [scrapy.Request(url=self.start_url, headers={'Referer': 'https://www.vivareal.com.br'})]

    def parse(self, response):
        for apartment in response.css('.results-list article'):
            loader = ApartmentLoader(selector=apartment)
            loader.add_css('name', 'h2 a::text')
            loader.add_value('address', self.get_address(apartment))

            details_loader = loader.nested_css('ul.property-card__details')
            details_loader.add_css('size', 'li.property-card__detail-area span::text')
            details_loader.add_css('rooms', 'li.js-property-detail-rooms span::text')
            details_loader.add_css('bathrooms', 'li.js-property-detail-bathroom span::text')
            details_loader.add_css('garages', 'li.js-property-detail-garages span::text')

            loader.add_css('rent', 'div.js-property-card__price-small::text')
            loader.add_css('condo', 'strong.js-condo-price::text')

            loader.add_css('description', 'div.js-property-description::text')
            loader.add_css('code', 'a.js-card-title::attr(href)')
            yield loader.load_item()

        next_page = response.css('a.js-change-page::attr(data-page)')[-1].extract()
        if next_page:
            next_page = '{url}?pagina={page}'.format(url=self.start_url, page=next_page)
            yield scrapy.Request(next_page, callback=self.parse)

    @classmethod
    def get_address(cls, response):
        address_loader = AddressLoader(selector=response)
        address_loader.add_css('street', 'h2 span::text')
        address_loader.add_css('district', 'h2 span::text')
        address_loader.add_css('city', 'h2 span::text')
        return address_loader.load_item()