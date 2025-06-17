import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import os

# Ingest the first 500 rows of the HR_Data.csv file
file_path = '../data/HR_Data.csv'
df = pd.read_csv(file_path)

# Basic exploration print
print("Head of data:")
print(df.head())
print("Data info:")
print(df.info())
print("Data description:")
print(df.describe(include='all'))

# Set seaborn style
sns.set(style='whitegrid')

# Create output directory for saving plots
output_dir = 'visualisation_files'
os.makedirs(output_dir, exist_ok=True)

def save_plot(fig, filename):
    filepath = os.path.join(output_dir, filename)
    fig.savefig(filepath, bbox_inches='tight')
    plt.close(fig)

# Numeric columns
numeric_cols = df.select_dtypes(include=['number']).columns.tolist()
# Categorical columns
cat_cols = df.select_dtypes(exclude=['number']).columns.tolist()

# 1. Distribution plots (histograms + KDE) for numeric
for col in numeric_cols:
    fig, ax = plt.subplots(figsize=(8, 5))
    sns.histplot(df[col], kde=True, ax=ax, color='steelblue')
    ax.set_title(f'Distribution of {col}')
    ax.set_xlabel(col)
    ax.set_ylabel('Frequency')
    save_plot(fig, f'distribution_{col}.png')

# 2. Boxplots for numeric data to visualize spread and outliers
for col in numeric_cols:
    fig, ax = plt.subplots(figsize=(8, 5))
    sns.boxplot(x=df[col], ax=ax, color='orange')
    ax.set_title(f'Boxplot of {col}')
    save_plot(fig, f'boxplot_{col}.png')

# 3. Countplots for categorical data with reasonable cardinality
for col in cat_cols:
    unique_vals = df[col].nunique()
    if unique_vals > 1 and unique_vals < 30:
        fig, ax = plt.subplots(figsize=(10, 6))
        sns.countplot(y=col, data=df, order=df[col].value_counts().index, ax=ax, palette='muted')
        ax.set_title(f'Countplot of {col}')
        save_plot(fig, f'countplot_{col}.png')

# 4. Correlation heatmap for numeric features
if len(numeric_cols) > 1:
    corr = df[numeric_cols].corr()
    fig, ax = plt.subplots(figsize=(10, 8))
    sns.heatmap(corr, annot=True, fmt='.2f', cmap='coolwarm', ax=ax)
    ax.set_title('Correlation Heatmap of Numeric Features')
    save_plot(fig, 'correlation_heatmap.png')

# 5. Pairplot to explore numeric variable relationships
if len(numeric_cols) > 1:
    pairplot = sns.pairplot(df[numeric_cols].dropna())
    pairplot.fig.suptitle('Pairplot of Numeric Features', y=1.02)
    pairplot.savefig(os.path.join(output_dir, 'pairplot_numeric_features.png'))
    plt.close()

# 6. Bar plots of mean numeric by categorical
for cat_col in cat_cols:
    unique_vals = df[cat_col].nunique()
    if unique_vals > 1 and unique_vals < 30:
        for num_col in numeric_cols:
            means = df.groupby(cat_col)[num_col].mean().sort_values(ascending=False)
            fig, ax = plt.subplots(figsize=(10, 6))
            sns.barplot(x=means.values, y=means.index, ax=ax, palette='plasma')
            ax.set_title(f'Average {num_col} by {cat_col}')
            ax.set_xlabel(f'Average {num_col}')
            ax.set_ylabel(cat_col)
            save_plot(fig, f'avg_{num_col}_by_{cat_col}.png')

# 7. Countplot of two categorical variables if exists
if len(cat_cols) >= 2:
    fig, ax = plt.subplots(figsize=(12, 8))
    sns.countplot(data=df, x=cat_cols[0], hue=cat_cols[1], ax=ax, palette='Set2')
    ax.set_title(f'Countplot of {cat_cols[0]} grouped by {cat_cols[1]}')
    plt.xticks(rotation=45)
    save_plot(fig, f'countplot_{cat_cols[0]}_by_{cat_cols[1]}.png')

print(f"Visualizations saved in '{output_dir}'")
