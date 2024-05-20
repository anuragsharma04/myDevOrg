import { LightningElement, api, track } from 'lwc';
import getNews from '@salesforce/apex/newsController.getNews';

export default class LwcNewsApi extends LightningElement {
    @track result = [];
    @track selectedNews = {};
    @track isModalOpen = false;
    @api selectedType = 'general'; 
    @api selectedCountry = 'in';
   // @api objectApiName;

  /*  selectedCountry(){
        if(this.objectApiName=='Account'){
            return this.selectedCountry='in';
        } else if(this.objectApiName=='Contact'){
            return this.selectedCountry='us';
        } else{
            return this.selectedCountry='jp';
        }
    }*/
   

    newsTypes = [
        { label: 'Business', value: 'business' },
        { label: 'Entertainment', value: 'entertainment' },
        { label: 'General', value: 'general' },
        { label: 'Health', value: 'health' },
        { label: 'Science', value: 'science' },
        { label: 'Sports', value: 'sports' },
        { label: 'Technology', value: 'technology' }
    ];

    country = [
        { label: 'United Arab Emirates (AE)', value: 'ae' },
        { label: 'Argentina (AR)', value: 'ar' },
        { label: 'Australia (AU)', value: 'au' },
        { label: 'Austria (AT)', value: 'at' },
        { label: 'Belgium (BE)', value: 'be' },
        { label: 'Bulgaria (BG)', value: 'bg' },
        { label: 'Brazil (BR)', value: 'br' },
        { label: 'Canada (CA)', value: 'ca' },
        { label: 'China (CN)', value: 'cn' },
        { label: 'Colombia (CO)', value: 'co' },
        { label: 'Czech Republic (CZ)', value: 'cz' },
        { label: 'Denmark (DK)', value: 'dk' },
        { label: 'Egypt (EG)', value: 'eg' },
        { label: 'France (FR)', value: 'fr' },
        { label: 'Germany (DE)', value: 'de' },
        { label: 'Greece (GR)', value: 'gr' },
        { label: 'Hong Kong (HK)', value: 'hk' },
        { label: 'Hungary (HU)', value: 'hu' },
        { label: 'India (IN)', value: 'in' },
        { label: 'Indonesia (ID)', value: 'id' },
        { label: 'Ireland (IE)', value: 'ie' },
        { label: 'Israel (IL)', value: 'il' },
        { label: 'Italy (IT)', value: 'it' },
        { label: 'Japan (JP)', value: 'jp' },
        { label: 'South Korea (KR)', value: 'kr' },
        { label: 'Lebanon (LB)', value: 'lb' },
        { label: 'Lithuania (LT)', value: 'lt' },
        { label: 'Latvia (LV)', value: 'lv' },
        { label: 'Morocco (MA)', value: 'ma' },
        { label: 'Mexico (MX)', value: 'mx' },
        { label: 'Malaysia (MY)', value: 'my' },
        { label: 'Nigeria (NG)', value: 'ng' },
        { label: 'Netherlands (NL)', value: 'nl' },
        { label: 'Norway (NO)', value: 'no' },
        { label: 'New Zealand (NZ)', value: 'nz' },
        { label: 'Philippines (PH)', value: 'ph' },
        { label: 'Poland (PL)', value: 'pl' },
        { label: 'Portugal (PT)', value: 'pt' },
        { label: 'Romania (RO)', value: 'ro' },
        { label: 'Russia (RU)', value: 'ru' },
        { label: 'Saudi Arabia (SA)', value: 'sa' },
        { label: 'Sweden (SE)', value: 'se' },
        { label: 'Singapore (SG)', value: 'sg' },
        { label: 'Slovenia (SI)', value: 'si' },
        { label: 'Slovakia (SK)', value: 'sk' },
        { label: 'Thailand (TH)', value: 'th' },
        { label: 'Turkey (TR)', value: 'tr' },
        { label: 'Taiwan (TW)', value: 'tw' },
        { label: 'Ukraine (UA)', value: 'ua' },
        { label: 'United Kingdom (UK)', value: 'uk' },
        { label: 'United States (US)', value: 'us' },
        { label: 'Venezuela (VE)', value: 've' },
        { label: 'South Africa (ZA)', value: 'za' },
    ];
    connectedCallback() {
        this.fetchNews();
    }

    fetchNews() {
        getNews({ type: this.selectedType, country: this.selectedCountry })
            .then(response => {
                console.log(response);
                this.formatNewsData(response.articles);
            })
            .catch(error => {
                console.error(error);
            });
    }

    handleTypeChange(event) {
        this.selectedType = event.detail.value;
        this.fetchNews();
    }

    handleCountryChange(event) {
        this.selectedCountry = event.detail.value;
        this.fetchNews();
    }

    formatNewsData(res) {
        this.result = res.map((item, index) => {
            let id = `new_${index + 1}`;
            let date = new Date(item.publishedAt).toDateString();
            let name = item.source.name;
            return { ...item, id: id, name: name, date: date };
        });
    }

    showModal(event) {
        let id = event.target.dataset.item;
        this.result.forEach(item => {
            if (item.id === id) {
                this.selectedNews = { ...item };
            }
        });
        this.isModalOpen = true;
    }

    closeModal() {
        this.isModalOpen = false;
    }
}