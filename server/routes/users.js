const router = require('express').Router();
const users = require('../controllers/users');

router.get('/:id', async (req, res) => {
    const data = await users().info({ id: req.params.id });
    res.status(200).json(data);
});

router.post('/:id', async (req, res) => {
    await users().create({
        id: req.params.id,

        first_name: req.body.first_name,
        last_name: req.body.last_name,
        gender: req.body.gender,
        photo: req.body.photo,
        email: req.body.email,
        is_locked: req.body.is_locked,
        phone: req.body.phone,
        phone_verifed: req.body.phone_verifed,
    });
    res.sendStatus(200);
});

router.put('/:id', async (req, res) => {
    await users().updateInfo({

        id: req.params.id,

        first_name: req.body.first_name,
        last_name: req.body.last_name,
        gender: req.body.gender,
        photo: req.body.photo,
        email: req.body.email,

        is_locked: req.body.is_locked,
        phone: req.body.phone,
        phone_verifed: req.body.phone_verifed,
    });
    res.sendStatus(200);
});


router.post('/:id/lock', async (req, res) => {
    await users().lock({ id: req.params.id });
    res.sendStatus(200);
});

router.post('/:id/unlock', async (req, res) => {
    await users().unlock({ id: req.params.id });
    res.sendStatus(200);
});

router.post('/:id/city/:city', async (req, res) => {
    await users().setCity({
        id: req.params.id,
        prefered_city: req.params.city
    });
    res.sendStatus(200);
});

router.post('/:id/lang/:lang', async (req, res) => {
    await users().setLanguage({
        id: req.params.id,
        prefered_lang: req.params.lang
    });
    res.sendStatus(200);
});


router.post('/:id/location/:lat/:lng', async (req, res) => {
    await users().setLocation({
        id: req.params.id,

        location_lat: req.params.lat,
        location_lng: req.params.lng,
    });
    res.sendStatus(200);
});




router.get('/:id/cart', async (req, res) => {
    const data = await users().getCart({ userId: req.params.id });
    res.status(200).send(data);
});

router.post('/:id/cart/:productId/:quantity', async (req, res) => {
    await users().cart({
        userId: req.params.id,
        productId: req.params.productId,
        quantity: req.params.quantity,
    });
    res.sendStatus(200);
});
router.delete('/cart/:id', async (req, res) => {
    await users().uncart({
        id: req.params.id,
    });
    res.sendStatus(200);
});
router.put('/cart/:id/:quantity', async (req, res) => {
    await users().updateCart({
        id: req.params.id,
        quantity: req.params.quantity,
    });
    res.sendStatus(200);
});


router.post('/:id/roles/:comapny/:role', async (req, res) => {
    await users().addCompanyRole({
        userId: req.params.id,
        companyId: req.params.comapny,
        role: req.params.role
    });
    res.sendStatus(200);
});
router.delete('/roles/:id', async (req, res) => {
    await users().removeCompanyRole({
        id: req.params.id,
    });
    res.sendStatus(200);
});




module.exports = router;