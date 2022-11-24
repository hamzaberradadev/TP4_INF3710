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
    //FIXME: je sais pas si on doit garder les quatres lignes ci-dessous et a quoi elles servent et comment elles marchent
    // const sep = "##//##";
    // const descriptions: string[] = planrepas.description.split(sep);
    // if (!planrepas.numeroplan || !planrepas.categorie.toString().length || !planrepas.commentairegeneral.length || descriptions.length !== 3 || !planrepas.nom.length || !planrepas.periodemiseenplace.length || !planrepas.perioderecolte.length) {
    //   throw new Error("Impossible de modifier la variété désirée.");
    // }
    const values: (string | number)[] = [
      planrepas.categorie,
      planrepas.frequence,
      planrepas.nbrpersonnes,
      planrepas.nbrcalories,
      planrepas.prix,
      planrepas.numerofournisseur,
      planrepas.numeroplan
    ]; //`UPDATE planrepas SET categorie = $1, anneeMiseEnMarche = $2, //FIXME: je pense pas que mon premier set est bon
    const queryText: string = `UPDATE planrepas SET categories = $1, frequence = $2, nbrpersonnes = $3, nbrcalories = $4, prix = $5, numerofournisseur = $6 WHERE numeroplan = $7;`; // FIXME: je ne comprends pas les $1
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
