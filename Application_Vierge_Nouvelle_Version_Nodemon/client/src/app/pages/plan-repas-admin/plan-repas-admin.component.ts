import { Component, OnInit } from '@angular/core';
import { MatDialog, MatDialogConfig } from '@angular/material/dialog';
import { CommunicationService } from '../../services/communication.service';
import { AddPlanRepasComponent } from '../add-plan-repas/add-plan-repas.component';

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
    const dialogConfig = new MatDialogConfig();
    // dialogConfig.disableClose = false;
    // dialogConfig.autoFocus = true;
    // dialogConfig.minWidth = '650px';
    // dialogConfig.maxWidth = '650px';
    this.dialog.open(AddPlanRepasComponent, dialogConfig);
  }

  // addPlanRepas(): void {
  //   // this.openDialog();
  //   // const sep = "##//##";
  //   this.communicationService.insertPlanRepas({
  //     numeroplan: 0,
  //     categorie: 'catégorie test',
  //     frequence: 7,
  //     nbrpersonnes: 7,
  //     nbrcalories: 7,
  //     prix: 7,
  //     numerofournisseur: 1,
  //   } as PlanRepas).subscribe((resInsVar: number) => {});
  // }

}
