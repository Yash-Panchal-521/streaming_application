import express from 'express';
import ExpressValidation from 'express-joi-validation';
import Joi from 'joi';
import { getChannelDetails, getChannels, postFollowChannel, getFollowedChannels } from '../controllers/controllers.js';
import { verifyToken } from '../middlewares/auth.js';

const router = express.Router();

const channelDetailsSchema = Joi.object({
    channelId: Joi.string().required(),
 });

const validation = ExpressValidation.createValidator({});

router.get('/followed', verifyToken, getFollowedChannels);

router.post('/follow', verifyToken, validation.body(channelDetailsSchema), postFollowChannel);

router.get('/:channelId', validation.params(channelDetailsSchema), getChannelDetails);

router.get('/', getChannels);
export default router;