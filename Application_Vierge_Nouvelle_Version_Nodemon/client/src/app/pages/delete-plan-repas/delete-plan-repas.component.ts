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
  }

  ngOnInit(): void {
  }

  deletePlanRepas() {
    this.communicationService.deletePlanrepas(this.numeroPlanADelete).subscribe((resInsVar: number) => {});
  }

}
