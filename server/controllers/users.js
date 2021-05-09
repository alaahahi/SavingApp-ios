const { userRepo, cartRepo, userCompanyRepo } = require('../infra/data');


function userController() {
    const users = userRepo();
    const carts = cartRepo();
    const userCompany = userCompanyRepo();

    return Object.freeze({
        create,
        info,
        updateInfo,


        setPushToken,
        setLocation,
        setCity,
        setLanguage,
        lock,
        unlock,

        cart,
        uncart,
        updateCart,
        // sendVerificationCode,
        // setVerifedPhone,

        addCompanyRole,
        removeCompanyRole,
    });

    function create({ first_name,
        last_name,
        email,
        phone,
        gender,
        photo,
        location_lng,
        location_lat,
        prefered_city,
        prefered_lang,
        is_locked,
        phone_verifed,
        push_notification_token,
    }) {
        return users.save({
            first_name,
            last_name,
            email,
            phone,
            gender,
            photo,
            location_lng,
            location_lat,
            prefered_city,
            prefered_lang,
            is_locked,
            phone_verifed,
            push_notification_token,
        });
    }

    function info({ id }) {
        return users.findOne({ where: { id } });
    }

    function updateInfo({
        id,
        first_name,
        last_name,
        email,
        phone,
        gender,
        photo,
        location_lng,
        location_lat,
        prefered_city,
        prefered_lang,
        is_locked,
        phone_verifed,
        push_notification_token,
    }) {
        return users.update({ id }, {
            first_name,
            last_name,
            email,
            phone,
            gender,
            photo,
            location_lng,
            location_lat,
            prefered_city,
            prefered_lang,
            is_locked,
            phone_verifed,
            push_notification_token,
        });
    }

    function setLocation({ id, location_lng, location_lat }) {
        return updateInfo({ id, location_lng, location_lat, });
    }

    function setCity({ id, prefered_city }) {
        return updateInfo({ id, prefered_city });
    }

    function setLanguage({ id, prefered_lang }) {
        return updateInfo({ id, prefered_lang });
    }

    function setPushToken({ id, push_notification_token }) {
        return updateInfo({ id, push_notification_token });
    }

    function lock({ id }) {
        return updateInfo({ id, is_locked: true });
    }

    function unlock({ id }) {
        return updateInfo({ id, is_locked: false });
    }

    function cart({ quantity, userId, productId }) {
        return carts.save({
            quantity,
            product: productId,
            user: userId,
        })
    }

    function uncart({ id }) {
        return carts.remove({ id });
    }

    function updateCart({ id, quantity }) {
        return carts.update({ id }, { quantity });
    }

    function addCompanyRole({ userId, companyId, role }) {
        return userCompany.save({
            user: userId,
            company: companyId,
            role,
        });
    }
    function removeCompanyRole({ id }) {
        return userCompany.remove({ id });
    }


    // async function sendVerificationCode({ phone, uid }) {
    //     // send sms with number 123-456 to phone
    //     await verificationCodes.build({
    //         phone,
    //         code: 123456,
    //         createdOn: 0000000,
    //         uid,
    //     });

    //     return true;
    // }

    // async function setVerifedPhone({ uid, phone, code }) {
    //     const codes = await verificationCodes.findAll({ phone, order: ['createdOn', 'DESC'] });
    //     for (const c of codes) {
    //         if (code === c.code
    //             // && c.createdOn > now + 24 hours
    //         ) {
    //             const user = await users.findOne({ uid });
    //             user.phone_verifed = true;
    //             user.phone = phone;
    //             await user.save();
    //             return true;
    //         }
    //     }

    //     return false;
    // }

}

module.exports = () => userController();