# BSChen
import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import minimize

def objective(vars):
    x, y = vars
    return 20 * x**2 + 35 * y**2

def constraint(vars):
    x, y = vars
    return 14 / (x - 0.3) + 21 / (y - 0.3) - 100

initial_guess = [0.8, 0.8]
bounds = [(0.3, None), (0.3, None)]
constraints = [{'type': 'eq', 'fun': constraint}]

result = minimize(
    objective,
    initial_guess,
    method='SLSQP',
    bounds=bounds,
    constraints=constraints
)

if result.success:
    x_optimal, y_optimal = result.x
    z_min = result.fun
    print(f"Optimal x = {x_optimal:.4f}")
    print(f"Optimal y = {y_optimal:.4f}")
    print(f"Minimum z = {z_min:.4f}")
else:
    print("Optimization failed:", result.message)

# ------------------------------------------------------------------------------------ #

def objective_function(x, y):
    return 20 * x**2 + 35 * y**2

def constraint_lhs(x, y):
    val = np.zeros_like(x, dtype=float)
    mask = (x > 0.3) & (y > 0.3)
    val[mask] = 14 / (x[mask] - 0.3) + 21 / (y[mask] - 0.3) - 100
    val[~mask] = np.nan
    return val

x = np.linspace(0.35, 1.0, 500)
y = np.linspace(0.35, 1.0, 500)
X, Y = np.meshgrid(x, y)

Z_objective = objective_function(X, Y)
Z_constraint_lhs = constraint_lhs(X, Y)

plt.figure(figsize=(10, 8))

contour_objective = plt.contour(X, Y, Z_objective, levels=40, cmap='viridis', alpha=0.7)
plt.colorbar(contour_objective, label='Z = 20x^2 + 35y^2')
plt.clabel(contour_objective, inline=True, fontsize=8, fmt='%1.0f')

contour_constraint = plt.contour(X, Y, Z_constraint_lhs, levels=[0], colors='red', linestyles='dashed', linewidths=2)
plt.clabel(contour_constraint, inline=True, fmt='Constraint', fontsize=10)

plt.plot(x_optimal, y_optimal, 'ro', markersize=5, label=f'Optimal Point ({x_optimal:.4f}, {y_optimal:.4f})')

plt.xlabel('x')
plt.ylabel('y')
plt.title('Objective Function Contour Plot with Constraint')
plt.grid(True, linestyle=':', alpha=0.6)
plt.axvline(x=0.3, color='gray', linestyle=':', label='x > 0.3 boundary')
plt.axhline(y=0.3, color='gray', linestyle=':', label='y > 0.3 boundary')

plt.xlim(0.3, 1.0)
plt.ylim(0.3, 1.0)

plt.gca().set_aspect('equal', adjustable='box')

plt.legend()
plt.show()
