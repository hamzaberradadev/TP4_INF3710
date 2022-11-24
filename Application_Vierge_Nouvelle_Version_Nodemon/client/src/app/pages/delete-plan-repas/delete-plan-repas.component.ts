import { Component, Input, OnInit } from '@angular/core';

@Component({
  selector: 'app-delete-plan-repas',
  templateUrl: './delete-plan-repas.component.html',
  styleUrls: ['./delete-plan-repas.component.css']
})
export class DeletePlanRepasComponent implements OnInit {

  @Input() numeroPlanADelete: number;

  // constructor(private readonly communicationService: CommunicationService) {
  //   this.numeroplan = 0;
  // }

  constructor() {}

  ngOnInit(): void {
  }

  deletePlanRepas() {
  //   this.communicationService.insertPlanRepas({
  //     numeroplan: 0,
  //     categorie: this.newPlanRepas.categorie,
  //     frequence: this.newPlanRepas.frequence,
  //     nbrpersonnes: this.newPlanRepas.nbrpersonnes,
  //     nbrcalories: this.newPlanRepas.nbrcalories,
  //     prix: this.newPlanRepas.prix,
  //     numerofournisseur: this.newPlanRepas.numerofournisseur,
  //   } as PlanRepas).subscribe((resInsVar: number) => {});
  console.log('le numero a delete est :' + this.numeroPlanADelete);
  }

}
