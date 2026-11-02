export type JwtPayload = {
        sub: number;
        nome: string;
        email: string;
};

declare global {
        namespace Express {
                interface Request {
                        user?: JwtPayload;
                }
        }
}