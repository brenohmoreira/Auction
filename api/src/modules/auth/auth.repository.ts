import { Injectable } from "@nestjs/common";
import { DatabaseService } from "../../database/database.service.js";

export type Usuario = { id: number; nome: string; email: string; senha: string; status: string };
export type UsuarioCriado = Pick<Usuario, "id" | "nome" | "email">;

@Injectable()
export class AuthRepository {
        constructor(private readonly db: DatabaseService) {}

        async pesquisaPorEmail(email: string): Promise<Usuario | null> {
                return this.db.consultarUm<Usuario>(`
                                SELECT id, nome, email, senha, status 
                                FROM Usuarios WHERE email = @email
                        `, { email }
                );
        }

        async criar(dados: Pick<Usuario, "nome" | "email" | "senha">): Promise<UsuarioCriado> {
                const usuario = await this.db.consultarUm<UsuarioCriado>(`
                                INSERT INTO Usuarios (nome, email, senha)
                                OUTPUT INSERTED.id, INSERTED.nome, INSERTED.email
                                VALUES (@nome, @email, @senha)
                        `, dados
                );

                return usuario!;
        }
}
