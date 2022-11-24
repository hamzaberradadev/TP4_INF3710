import { Component, OnInit } from '@angular/core';
import { CommunicationService } from '../../services/communication.service';

export interface PlanRepas {
  numeroplan: number;
  categorie: string;
  frequence: number;
  nbrpersonnes: number;
  nbrcalories: number;
  prix: number;
  numerofournisseur: number;
}

@Component({
  selector: 'app-plan-repas',
  templateUrl: './plan-repas.component.html',
  styleUrls: ['./plan-repas.component.css']
})
export class PlanRepasComponent implements OnInit {

  planrepaslist: PlanRepas[];
  columnsToDisplay = ['numeroplan', 'categorie', 'frequence', 'nbrpersonnes', 'nbrcalories', 'prix', 'numerofournisseur'];

  constructor(private readonly communicationService: CommunicationService) {}

  ngOnInit(): void {
    this.getAllPlanRepas();
  }

  public getAllPlanRepas(): void {
    this.communicationService.getAllPlanRepas().subscribe((planrepaslist: PlanRepas[]) => {
      this.planrepaslist = planrepaslist ? planrepaslist : [];
      console.log(planrepaslist);
    });
  }

}
