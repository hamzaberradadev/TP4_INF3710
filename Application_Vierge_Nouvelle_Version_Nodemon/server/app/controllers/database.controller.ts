import { NextFunction, Request, Response, Router } from "express";
import { inject, injectable } from "inversify";
import { DatabaseService } from "../services/database.service";
import { PlanRepas } from '../../../common/tables/PlanRepas';
import Types from "../types";
import * as pg from "pg";

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
            numéroplan: planrepas.numéroplan,
            catégorie: planrepas.catégorie,
            fréquence: planrepas.fréquence,
            nbrpersonnes: planrepas.nbrpersonnes,
            nbrcalories: planrepas.nbrcalories,
            prix: planrepas.prix,
            numérofournisseur: planrepas.numérofournisseur,
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
            numéroplan: planrepas.numéroplan,
            catégorie: planrepas.catégorie,
            fréquence: planrepas.fréquence,
            nbrpersonnes: planrepas.nbrpersonnes,
            nbrcalories: planrepas.nbrcalories,
            prix: planrepas.prix,
            numérofournisseur: planrepas.numérofournisseur,
          } as PlanRepas));
          res.json(planrepaslist);
        })
        .catch((e: Error) => {
          console.error(e.stack);
        });
      }
    });

    return router;
  }
}
