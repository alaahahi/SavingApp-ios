require('dotenv').config();
const categories = require("./controllers/categories");
const { DbProvider } = require("./infra/data");


DbProvider(async () => {
    const repo = categories();
    await repo.removeTranslation({ id: 8 });
    console.log(await repo.getTranslates({
        category_id: 2, title: 'fiiie', lang: 'en',
    }))
    // console.log(await repo.getAll({ lang: 'en' }))
    // await repo.create({
    //     title: 'weww',
    //     logo: 'logo',
    //     order: 1,
    //     lang: 'en',
    // });
    // console.log(await repo.getAll({ lang: 'ar' }));

});