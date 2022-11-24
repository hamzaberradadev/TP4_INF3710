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

export interface Fournisseurs {
  numerofournisseurs: number,
  nomfournisseur: string,
  adressefournisseur: string;
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
    const queryText: string = `SELECT * FROM planrepas ORDER BY numeroplan ASC;`;
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
  
  public async deleteByNumeroplan(numeroplan: number): Promise<pg.QueryResult> {
    const client = await this.pool.connect();
    console.log(numeroplan);
    if (!numeroplan) {
      throw new Error("Impossible de supprimer le plan repas.");
    }
    const values: number[] = [
      numeroplan
    ];
    const queryText: string = `DELETE FROM planrepas WHERE numeroplan = $1;`;
    const res = await client.query(queryText, values);
    client.release()
    return res;
  }

  public async updatePlanRepas(planrepas: PlanRepas): Promise<pg.QueryResult> {
    const client = await this.pool.connect();
    const values: (string | number)[] = [
      planrepas.categorie,
      planrepas.frequence,
      planrepas.nbrpersonnes,
      planrepas.nbrcalories,
      planrepas.prix,
      planrepas.numerofournisseur,
      planrepas.numeroplan
    ];
    const queryText: string = `UPDATE planrepas SET categorie = $1, frequence = $2, nbrpersonnes = $3, nbrcalories = $4, prix = $5, numerofournisseur = $6 WHERE numeroplan = $7;`; // FIXME: je ne comprends pas les $1
    const res = await client.query(queryText, values);
    client.release();
    return res;
  }

  async getAllFournisseurs(): Promise<pg.QueryResult> {
    const client = await this.pool.connect();
    const queryText: string = `SELECT * FROM fournisseur;`;
    const res = await client.query(queryText);
    client.release();
    return res;
  }
}
