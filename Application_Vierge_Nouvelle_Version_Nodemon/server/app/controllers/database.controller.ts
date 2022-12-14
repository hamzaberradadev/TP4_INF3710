import { NextFunction, Request, Response, Router } from "express";
import { inject, injectable } from "inversify";
import { DatabaseService } from "../services/database.service";
// import { PlanRepas } from '../../../common/tables/PlanRepas';
// import { Fournisseurs } from "../../../common/tables/Fournisseurs";
import Types from "../types";
import * as pg from "pg";

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
export class DatabaseController {
  public constructor(
    // @ts-ignore -- À ENLEVER LORSQUE L'IMPLÉMENTATION EST TERMINÉE
    @inject(Types.DatabaseService) private readonly databaseService: DatabaseService
  ) {}

  public get router(): Router {
    const router: Router = Router();

    router.get("/planrepas/:id?", (req: Request, res: Response, _: NextFunction) => {
      if(req.params.id) {
        this.databaseService
        .getPlanRepas(Number(req.params.id))
        .then((result: pg.QueryResult) => {
          const planrepaslist: PlanRepas[] = result.rows.map((planrepas: PlanRepas) => ({
            numeroplan: planrepas.numeroplan,
            categorie: planrepas.categorie,
            frequence: planrepas.frequence,
            nbrpersonnes: planrepas.nbrpersonnes,
            nbrcalories: planrepas.nbrcalories,
            prix: planrepas.prix,
            numerofournisseur: planrepas.numerofournisseur,
          } as PlanRepas));
          res.json(planrepaslist);
        })
        .catch((e: Error) => {
          console.error(e.stack);
        });
      } else {
        this.databaseService
        .getAllPlanRepas()
        .then((result: pg.QueryResult) => {
          const planrepaslist: PlanRepas[] = result.rows.map((planrepas: PlanRepas) => ({
            numeroplan: planrepas.numeroplan,
            categorie: planrepas.categorie,
            frequence: planrepas.frequence,
            nbrpersonnes: planrepas.nbrpersonnes,
            nbrcalories: planrepas.nbrcalories,
            prix: planrepas.prix,
            numerofournisseur: planrepas.numerofournisseur,
          } as PlanRepas));
          res.json(planrepaslist);
        })
        .catch((e: Error) => {
          console.error(e.stack);
        });
      }
    });

    router.post(
      "/planrepas",
      (req: Request, res: Response, _: NextFunction) => {
        const planrepas: PlanRepas = {
          numeroplan: req.body.numeroplan,
          categorie: req.body.categorie,
          frequence: req.body.frequence,
          nbrpersonnes: req.body.nbrpersonnes,
          nbrcalories: req.body.nbrcalories,
          prix: req.body.prix,
          numerofournisseur: req.body.numerofournisseur,
        };
        this.databaseService
          .addPlanRepas(planrepas)
          .then((result: pg.QueryResult) => {
            res.json(result.rowCount);
          })
          .catch((e: Error) => {
            console.error(e.stack);
            res.json(-1);
          });
      }
    );

    router.delete("/planrepas/:id", (req: Request, res: Response, _: NextFunction) => {
        this.databaseService
          .deleteByNumeroplan(parseInt(req.params.id))
          .then((result: pg.QueryResult) => {
            res.json(result.rowCount);
          })
          .catch((e: Error) => {
            console.error(e.stack);
            res.json(-1);
          });
      }
    );

    router.put("/planrepas", (req: Request, res: Response, _: NextFunction) => {
        // FIXME: est-ce que PlanRepas a ete ajoute par dorian ?
        const planrepas: PlanRepas = {
          numeroplan: req.body.numeroplan,
          categorie: req.body.categorie,
          frequence: req.body.frequence,
          nbrpersonnes: req.body.nbrpersonnes,
          nbrcalories: req.body.nbrcalories,
          prix: req.body.prix,
          numerofournisseur: req.body.numerofournisseur,
        };
        this.databaseService
          .updatePlanRepas(planrepas)
          .then((result: pg.QueryResult) => {
            res.json(result.rowCount);
          })
          .catch((e: Error) => {
            console.error(e.stack);
            res.json(-1);
          });
      }
    );
    router.get("/fournisseur", (req: Request, res: Response, _: NextFunction) => {
      this.databaseService
        .getAllFournisseurs()
        .then((result: pg.QueryResult) => {
          const listeFournisseurs: Fournisseurs[] = result.rows.map((listeFournisseurs: Fournisseurs) => ({
            numerofournisseurs: listeFournisseurs.numerofournisseurs,
            nomfournisseur: listeFournisseurs.nomfournisseur,
            adressefournisseur: listeFournisseurs.adressefournisseur,
          } as Fournisseurs));
          res.json(listeFournisseurs);
        })
        .catch((e: Error) => {
          console.error(e.stack);
        });
    });
    return router;
  }
}
