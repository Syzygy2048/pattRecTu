function [roundness] = roundness(area, perimeter)

roundness = (4*area)/(pi*perimeter^2);