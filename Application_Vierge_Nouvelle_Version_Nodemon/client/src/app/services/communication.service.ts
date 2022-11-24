// À DÉCOMMENTER ET À UTILISER LORSQUE VOTRE COMMUNICATION EST IMPLÉMENTÉE
import { HttpClient } from "@angular/common/http";
import { Injectable } from "@angular/core";
import { of, Observable, Subject } from "rxjs";
import { catchError } from "rxjs/operators";

export interface PlanRepas {
  numeroplan: number;
  categorie: string;
  frequence: number;
  nbrpersonnes: number;
  nbrcalories: number;
  prix: number;
  numerofournisseur: number;
}

@Injectable()
export class CommunicationService {
  // À DÉCOMMENTER ET À UTILISER LORSQUE VOTRE COMMUNICATION EST IMPLÉMENTÉE
  private readonly BASE_URL: string = "http://localhost:3000/database";
  public constructor(private readonly http: HttpClient) {}

  private _listeners: any = new Subject<any>();

  listen(): Observable<any> {
    return this._listeners.asObservable();
  }

  filter(filterBy: string): void {
    this._listeners.next(filterBy);
  }

  getAllPlanRepas(): Observable<PlanRepas[]> {
    return this.http
      .get<PlanRepas[]>(this.BASE_URL + "/planrepas")
      .pipe(catchError(this.handleError<PlanRepas[]>("getAllPlanRepas")));
  }

  getSpecificPlanRepas(id: number): Observable<PlanRepas[]> {
    return this.http
      .get<PlanRepas[]>(this.BASE_URL + `/planrepas/${id}`)
      .pipe(catchError(this.handleError<PlanRepas[]>("getSpecificPlanRepas")));
  }

  private handleError<T>(
    request: string,
    result?: T
  ): (error: Error) => Observable<T> {
    return (error: Error): Observable<T> => {
      return of(result as T);
    };
  }
}
