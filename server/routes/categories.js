const router = require('express').Router();
const categories = require('../controllers/categories');
const companies = require('../controllers/companies');


router.get('/', async (req, res) => {
    const data = await categories().getAll({ lang: req.query.lang });
    res.status(200).json(data);
});

router.get('/:id', async (req, res) => {
    const data = await categories().get({ lang: req.query.lang, id: req.params.id });
    res.status(200).json(data);
});

router.get('/:id/companies', async (req, res) => {
    const data = await companies().getAll({
        categoryId: req.params.id,
        lang: req.query.lang
    });
    res.status(200).json(data);
});

router.get('/:id/companies/featured', async (req, res) => {
    const data = await companies().getFeatured({
        categoryId: req.params.id,
        lang: req.query.lang
    });
    res.status(200).json(data);
});


router.post('/', async (req, res) => {
    const { title, photo, logo, visible, order, lang } = req.body;
    const data = await categories().create({
        logo,
        visible,
        order,

        title,
        photo,
        lang: lang || req.query.lang
    });
    res.status(200).json(data);
});

router.put('/:id', async (req, res) => {
    const { logo, visible, order } = req.body;

    const data = await categories().update({
        id: req.params.id,
        logo,
        visible,
        order,
    });
    res.status(200).json(data);
});

router.delete('/:id', async (req, res) => {
    await categories().remove({
        id: req.params.id
    });
    res.sendStatus(200);
});


router.get('/:id/translations', async (req, res) => {
    const data = await categories().getTranslates({
        categoryId: req.params.id
    });
    res.status(200).json(data);
});

router.post('/:id/translations', async (req, res) => {
    const { title, photo, lang, } = req.body;

    await categories().addTranslation({
        categoryId: req.params.id,
        title,
        photo,
        lang: lang || req.query.lang
    });
    res.sendStatus(200);
});

router.put('/translations/:id', async (req, res) => {
    const { title, photo, lang, } = req.body;

    await categories().updateTranslation({
        id: req.params.id,
        title,
        photo,
        lang: lang || req.query.lang
    });
    res.sendStatus(200);
});

router.delete('/translations/:id', async (req, res) => {
    await categories().removeTranslation({
        id: req.params.id
    });
    res.sendStatus(200);
});

module.exports = router;