import { LightningElement, api, track } from 'lwc';
import getNews from '@salesforce/apex/newsController.getNews';

export default class NewsComponent extends LightningElement {
    @track result = [];
    @track selectedNews = {};
    @track isModalOpen = false;
    @api selectedType = 'business'; 
    @api selectedCountry = 'us'; 

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