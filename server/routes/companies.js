const router = require('express').Router();
const companies = require('../controllers/companies');
const products = require('../controllers/products');


router.get('/search', async (req, res) => {
    const data = await companies().search({
        query: req.query.query,
        lang: req.query.lang,
    });
    res.status(200).json(data);
});

router.get('/:id', async (req, res) => {
    const data = await companies().getById({
        id: req.params.id,
        lang: req.query.lang
    });
    res.status(200).json(data);
});


router.get('/:id/products', async (req, res) => {
    const data = await products().getAll({
        companyId: req.params.id,
        lang: req.query.lang,
    });
    res.status(200).json(data);
});


router.post('/', async (req, res) => {
    const {
        title,
        desc,
        photo,
        logo,
        phone,
        close_minute,
        open_minute,
        featured,
        location_lng,
        location_lat,
        visible,
        lang,
        categoryId,
    } = req.body;

    await companies().create({
        logo,
        phone,
        close_minute,
        open_minute,
        featured,
        location_lng,
        location_lat,
        categoryId,
        visible,

        title,
        desc,
        photo,
        lang: lang || req.query.lang,
    });
    res.sendStatus(200);
});


router.put('/:id', async (req, res) => {
    const {
        logo,
        phone,
        close_minute,
        open_minute,
        featured,
        categoryId,
        location_lng,
        location_lat,
        visible,
    } = req.body;

    await companies().update({
        id: req.params.id,
        logo,
        phone,
        close_minute,
        open_minute,
        featured,
        location_lng,
        location_lat,
        visible,
        categoryId,
    });
    res.sendStatus(200);
});


router.get('/:id/translations', async (req, res) => {
    const data = await companies().getTranslates({ companyId: req.params.id });
    res.status(200).json(data);
});

router.post('/:id/translations', async (req, res) => {
    const { title, photo, desc, lang } = req.body;
    await companies().addTranslation({
        title,
        photo,
        desc,
        lang,
        companyId: req.params.id,
    });
    res.sendStatus(200);
});

router.put('/translations/:id', async (req, res) => {
    const { title, photo, desc, lang, } = req.body;

    await companies().updateTranslation({
        id: req.params.id,
        title,
        photo,
        desc,
        lang,
    });
    res.sendStatus(200);
});

router.delete('/translations/:id', async (req, res) => {
    await companies().removeTranslation({
        id: req.params.id
    });
    res.sendStatus(200);
});

module.exports = router;