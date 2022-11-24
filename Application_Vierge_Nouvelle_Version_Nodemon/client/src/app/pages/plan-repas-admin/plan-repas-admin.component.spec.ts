import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PlanRepasAdminComponent } from './plan-repas-admin.component';

describe('PlanRepasAdminComponent', () => {
  let component: PlanRepasAdminComponent;
  let fixture: ComponentFixture<PlanRepasAdminComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PlanRepasAdminComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(PlanRepasAdminComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
