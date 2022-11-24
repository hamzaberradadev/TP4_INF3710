import { Component, OnInit } from '@angular/core';
import { FormGroup } from '@angular/forms';
// import { MAT_DIALOG_DATA } from '@angular/material/dialog';
import { CommunicationService } from 'src/app/services/communication.service';

export class PlanRepas {
  numeroplan: number = 0;
  categorie: string = '';
  frequence: number = 0;
  nbrpersonnes: number = 0;
  nbrcalories: number = 0;
  prix: number = 0;
  numerofournisseur: number = 0;
}

@Component({
  selector: 'app-add-plan-repas',
  templateUrl: './add-plan-repas.component.html',
  styleUrls: ['./add-plan-repas.component.css']
})
export class AddPlanRepasComponent implements OnInit {
  firstFormGroup: FormGroup;
  newPlanRepas: PlanRepas;
  // categorie: string = 'salt';
  // frequence: string = '';
  // nbrpersonnes: string = '';
  // nbrcalories: string = '';
  // prix: string = '';
  // numerofournisseur: string = '';

  constructor(private readonly communicationService: CommunicationService) {
    this.newPlanRepas = new PlanRepas()
    this.newPlanRepas.numeroplan = 0;
  }
  // constructor() {
  //   this.newPlanRepas = new PlanRepas()
  // }

  ngOnInit(): void {
    // this.newPlanRepas = new PlanRepas();
    // this.newPlanRepas = this.data;
  }

  addPlanRepas(): void {
    // this.openDialog();
    // const sep = "##//##";
    this.communicationService.insertPlanRepas({
      numeroplan: 0,
      categorie: this.newPlanRepas.categorie,
      frequence: this.newPlanRepas.frequence,
      nbrpersonnes: this.newPlanRepas.nbrpersonnes,
      nbrcalories: this.newPlanRepas.nbrcalories,
      prix: this.newPlanRepas.prix,
      numerofournisseur: this.newPlanRepas.numerofournisseur,
    } as PlanRepas).subscribe((resInsVar: number) => {});
    // this.newPlanRepas.categorie = this.categorie;
    // this.categorie = this.categorie;
    // console.log(this.newPlanRepas);
  }

}
