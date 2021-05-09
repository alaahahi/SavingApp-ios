const router = require('express').Router();
const products = require('../controllers/products');

router.get('/featured', async (req, res) => {
    const data = await products().getFeatured({ lang: req.query.lang });
    res.status(200).json(data);
});

router.post('/', async (req, res) => {
    const {
        title,
        desc,
        lang,

        photo,
        featured,
        companyId,
        price,
        visible,
        discount_end_data,
        discount_price,
        discount_start_data,
    } = req.body;

    const data = await products().create({
        companyId,
        lang,
        title,
        desc,

        featured,
        photo,
        price,
        visible,
        discount_end_data,
        discount_price,
        discount_start_data
    });
    res.status(200).json(data);
});


router.put('/:id', async (req, res) => {
    const {
        featured,
        companyId,
        photo,
        price,
        visible,
        discount_end_data,
        discount_price,
        discount_start_data
    } = req.body;

    await products().update({
        id: req.params.id,
        featured,
        companyId,
        photo,
        price,
        visible,
        discount_end_data,
        discount_price,
        discount_start_data
    });
    res.sendStatus(200);
});



router.get('/:id/translations', async (req, res) => {
    const data = await products().getTranslates({ productId: req.params.id });
    res.status(200).json(data);
});

router.post('/:id/translations', async (req, res) => {
    const { title, desc, lang } = req.body;
    await products().addTranslation({
        title,
        desc,
        lang,
        productId: req.params.id
    });
    res.sendStatus(200);
});

router.put('/translations/:id', async (req, res) => {
    const { title, desc, lang, } = req.body;

    await products().updateTranslation({
        id: req.params.id,
        title,
        desc,
        lang,
    });
    res.sendStatus(200);
});

router.delete('/translations/:id', async (req, res) => {
    await products().removeTranslation({
        id: req.params.id
    });
    res.sendStatus(200);
});

module.exports = router;