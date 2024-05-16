import express from 'express';
import ExpressValidation from 'express-joi-validation';
import Joi from 'joi';
import { verifyToken } from '../middlewares/auth.js';
import { getChannelSettings, putChannelSettings, patchChangePassword } from '../controllers/controllers.js';

const router = express.Router();

const validator = ExpressValidation.createValidator({});

const channelSettingsSchema = Joi.object({
    username: Joi.string().min(3).max(12),
    description: Joi.string().min(10).max(200),
    title: Joi.string().min(3).max(30),
    avatarUrl: Joi.string().uri(),
});

const chnagePasswordSchema = Joi.object({
    password: Joi.string().min(6).max(30).required(),
    newPassword: Joi.string().min(6).max(30).required(),
});

router.get('/channel', verifyToken, getChannelSettings);

router.put('/channel', verifyToken, validator.body(channelSettingsSchema), putChannelSettings);

router.patch('/password', verifyToken, validator.body(chnagePasswordSchema), patchChangePassword);
export default router;