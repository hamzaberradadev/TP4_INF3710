import { injectable } from "inversify";
import * as pg from "pg";
import "reflect-metadata";

export interface PlanRepas {
  numeroplan: number;
  categorie: string;
  frequence: number;
  nbrpersonnes: number;
  nbrcalories: number;
  prix: number;
  numerofournisseur: number;
}

@injectable()
export class DatabaseService {
  public connectionConfig: pg.ConnectionConfig = {
    user: "admin",
    database: "TP4_Livraison",
    password: "admin123",
    port: 5432,          // Attention ! Peut aussi être 5433 pour certains utilisateurs
    host: "127.0.0.1",
    keepAlive: true
  };

  public pool: pg.Pool = new pg.Pool(this.connectionConfig);

  async getAllPlanRepas(): Promise<pg.QueryResult> {
    const client = await this.pool.connect();
    const queryText: string = `SELECT * FROM planrepas;`;
    const res = await client.query(queryText);
    client.release();
    return res;
  }

  async getPlanRepas(id: number): Promise<pg.QueryResult> {
    const client = await this.pool.connect();
    const queryText: string = `SELECT * FROM planrepas WHERE numeroplan = ${id.toString()};`;
    const res = await client.query(queryText);
    client.release();
    return res;
  }

//   INSERT INTO Planrepas(categorie, frequence, nbrpersonnes,
//     nbrcalories, prix, numerofournisseur)
// VALUES('cetogène', 2, 2, 572, 30, (SELECT numerofournisseur FROM Fournisseur
// WHERE nomFournisseur='QC Transport'));

  async addPlanRepas(planrepas: PlanRepas): Promise<pg.QueryResult> {
    const client = await this.pool.connect();
    const values: (string | number)[] = [
      planrepas.categorie,
      planrepas.frequence,
      planrepas.nbrpersonnes,
      planrepas.nbrcalories,
      planrepas.prix,
      planrepas.numerofournisseur,
    ];
    const queryText: string = `INSERT INTO planrepas(categorie, frequence, nbrpersonnes, nbrcalories, prix, numerofournisseur) VALUES($1, $2, $3, $4, $5, $6);`;
    const res = await client.query(queryText, values);
    client.release();
    return res;
  }
}
