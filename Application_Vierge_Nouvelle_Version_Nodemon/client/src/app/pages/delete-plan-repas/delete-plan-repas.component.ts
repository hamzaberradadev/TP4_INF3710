import { Component, Input, OnInit } from '@angular/core';
import { CommunicationService } from 'src/app/services/communication.service';

@Component({
  selector: 'app-delete-plan-repas',
  templateUrl: './delete-plan-repas.component.html',
  styleUrls: ['./delete-plan-repas.component.css']
})
export class DeletePlanRepasComponent implements OnInit {

  @Input() numeroPlanADelete: number;

  constructor(private readonly communicationService: CommunicationService) {
    // this.numeroplan = 0;
  }

  // constructor() {}

  ngOnInit(): void {
  }

  deletePlanRepas() {
    this.communicationService.deletePlanrepas(this.numeroPlanADelete).subscribe((resInsVar: number) => {});
  // console.log('le numero a delete est :' + this.numeroPlanADelete);
  }

}
