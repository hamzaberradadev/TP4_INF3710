import { Component, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { CommunicationService } from '../../services/communication.service';
import { AddPlanRepasComponent } from '../add-plan-repas/add-plan-repas.component';
import { UpdatePlanRepasComponent } from '../update-plan-repas/update-plan-repas.component';

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
  selector: 'app-plan-repas-admin',
  templateUrl: './plan-repas-admin.component.html',
  styleUrls: ['./plan-repas-admin.component.css']
})
export class PlanRepasAdminComponent implements OnInit {

  planrepaslist: PlanRepas[];
  columnsToDisplay = ['numeroplan', 'categorie', 'frequence', 'nbrpersonnes', 'nbrcalories', 'prix', 'numerofournisseur'];

  constructor(public dialog: MatDialog, private readonly communicationService: CommunicationService) {}

  ngOnInit(): void {
    this.getAllPlanRepas();
  }

  public getAllPlanRepas(): void {
    this.communicationService.getAllPlanRepas().subscribe((planrepaslist: PlanRepas[]) => {
      this.planrepaslist = planrepaslist ? planrepaslist : [];
      console.log(planrepaslist);
    });
  }

  openAddDialog() {
    this.dialog.open(AddPlanRepasComponent);
  }
  
  openUpdateDialog(planRepasToUpdate: PlanRepas) {
    this.dialog.open(UpdatePlanRepasComponent, {
      data: { planRepas: planRepasToUpdate },
    });
  }

}
