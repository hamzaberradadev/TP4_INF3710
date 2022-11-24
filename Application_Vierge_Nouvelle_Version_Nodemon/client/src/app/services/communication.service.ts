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

export interface Fournisseurs {
  numerofournisseurs: number,
  nomfournisseur: string,
  adressefournisseur: string;
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

  public insertPlanRepas(planrepas: PlanRepas): Observable<number> {
    return this.http
      .post<number>(this.BASE_URL + "/planrepas", planrepas)
      .pipe(catchError(this.handleError<number>("insertPlanrepas")));
  }

  public deletePlanrepas(numeroPlanrepas: number): Observable<number> {
    return this.http
      .delete<number>(this.BASE_URL + `/planrepas/${numeroPlanrepas}`)
      .pipe(catchError(this.handleError<number>("deletePlanrepas")));
  }

  public updatePlanrepas(planrepas: PlanRepas): Observable<number> {
    return this.http
      .put<number>(this.BASE_URL + "/planrepas", planrepas)
      .pipe(catchError(this.handleError<number>("updatePlanrepas")));
  }

  getAllFournisseurs(): Observable<Fournisseurs[]> {
    return this.http
      .get<Fournisseurs[]>(this.BASE_URL + "/fournisseur")
      .pipe(catchError(this.handleError<Fournisseurs[]>("getAllPlanRepas")));
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
