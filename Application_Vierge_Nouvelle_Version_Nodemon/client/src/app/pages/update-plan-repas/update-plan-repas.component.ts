import { Component, Inject, OnInit } from '@angular/core';
import { FormGroup } from '@angular/forms';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';
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
  selector: 'app-update-plan-repas',
  templateUrl: './update-plan-repas.component.html',
  styleUrls: ['./update-plan-repas.component.css']
})
export class UpdatePlanRepasComponent implements OnInit {
  newPlanRepas: PlanRepas = new PlanRepas();
  firstFormGroup: FormGroup;

  constructor(@Inject(MAT_DIALOG_DATA) public data: { planRepas: PlanRepas }, private readonly communicationService: CommunicationService) {
    this.newPlanRepas = data.planRepas;
}


  ngOnInit(): void {
  }

  updatePlanRepas(): void {
    this.communicationService.updatePlanrepas(this.newPlanRepas).subscribe((resInsVar: number) => {});
  }

}
