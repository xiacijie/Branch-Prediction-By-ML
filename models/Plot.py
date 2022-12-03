from sklearn.model_selection import learning_curve
import plotly.graph_objects as go
import numpy as np
from sklearn.base import clone


def plot_learning_curves(estimator, X, y, cv, scoring, model_name):
    estimator = clone(estimator)
    train_sizes, train_scores, test_scores = learning_curve(
        estimator=estimator,
        X=X,
        y=y,
        train_sizes=np.linspace(0.1, 1.0, 8),
        cv=cv,
        scoring=scoring,
        random_state=42,
        n_jobs=-1
    )
    train_mean = np.mean(train_scores, axis=1)
    test_mean = np.mean(test_scores, axis=1)

    fig = go.Figure()

    fig.add_trace(
        go.Scatter(
            x=train_sizes,
            y=train_mean,
            name="Training " + scoring,
            mode="lines",
            line=dict(color="blue"),
        )
    )

    fig.add_trace(
        go.Scatter(
            x=train_sizes,
            y=test_mean,
            name="Validation " + scoring,
            mode="lines",
            line=dict(color="green"),
        )
    )

    fig.update_layout(
        title="Learning Curves",
        xaxis_title="Number of training examples",
        yaxis_title=scoring,
    )

    fig.write_image(model_name + "_curve.png")