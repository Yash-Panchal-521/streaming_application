import jwt from 'jsonwebtoken';

const config = process.env;

export const verifyToken = async (req, res, next)  => {
    let token = await req.body.token || req.query.token || req.headers['authorization'];

    if (!token) {
        return res.status(401).send('A token is required for authentication');
    }

    try {
        token = token.replace('Bearer ', '');
        const decoded = jwt.verify(token, config.TOKEN_KEY);
        req.user = decoded;
    } catch (err) {
        return res.status(401).send('Invalid Token');
    }

    return next();

};
