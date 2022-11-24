import { NextFunction, Request, Response, Router } from "express";
import { inject, injectable } from "inversify";
import { DatabaseService } from "../services/database.service";
// import { PlanRepas } from '../../../common/tables/PlanRepas';
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

    return router;
  }
}
