import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import os

file_path = '../data/HR_Data.csv'
df = pd.read_csv(file_path, nrows=500)

# Basic data inspection
print(df.head())
print(df.info())
print(df.describe(include='all'))

# Set seaborn style
sns.set(style='whitegrid')

# Create output directory for plots
output_dir = 'visualisation_files'
os.makedirs(output_dir, exist_ok=True)

# Helper function to save plots
def save_plot(fig, name):
    fig.savefig(f'{output_dir}/{name}.png', bbox_inches='tight')
    plt.close(fig)

# 1. Distribution of numeric features
numeric_cols = df.select_dtypes(include=['number']).columns.tolist()
for col in numeric_cols:
    fig, ax = plt.subplots(figsize=(8,5))
    sns.histplot(df[col], kde=True, ax=ax, color='blue')
    ax.set_title(f'Distribution of {col}')
    ax.set_xlabel(col)
    ax.set_ylabel('Frequency')
    save_plot(fig, f'distribution_{col}')

# 2. Boxplots of numeric variables to detect outliers
for col in numeric_cols:
    fig, ax = plt.subplots(figsize=(8,5))
    sns.boxplot(x=df[col], ax=ax, color='orange')
    ax.set_title(f'Boxplot of {col}')
    save_plot(fig, f'boxplot_{col}')

# 3. Countplot of categorical variables
cat_cols = df.select_dtypes(exclude=['number']).columns.tolist()
for col in cat_cols:
    if df[col].nunique() > 1 and df[col].nunique() < 30:
        fig, ax = plt.subplots(figsize=(10,6))
        sns.countplot(y=col, data=df, order=df[col].value_counts().index, ax=ax, palette='viridis')
        ax.set_title(f'Countplot of {col}')
        save_plot(fig, f'countplot_{col}')

# 4. Correlation heatmap for numeric features
if len(numeric_cols) > 1:
    corr = df[numeric_cols].corr()
    fig, ax = plt.subplots(figsize=(10,8))
    sns.heatmap(corr, annot=True, fmt='.2f', cmap='coolwarm', ax=ax)
    ax.set_title('Correlation Heatmap of Numeric Features')
    save_plot(fig, 'correlation_heatmap')

# 5. Pairplot of numeric features
if len(numeric_cols) > 1:
    pairplot = sns.pairplot(df[numeric_cols].dropna())
    pairplot.fig.suptitle('Pairplot of Numeric Features', y=1.02)
    save_plot(pairplot.fig, 'pairplot_numeric_features')

# 6. Bar plot of average numeric features grouped by categorical variables
for cat_col in cat_cols:
    for num_col in numeric_cols:
        if df[cat_col].nunique() > 1 and df[cat_col].nunique() < 30:
            grouped = df.groupby(cat_col)[num_col].mean().sort_values(ascending=False)
            fig, ax = plt.subplots(figsize=(10,6))
            sns.barplot(x=grouped.values, y=grouped.index, ax=ax, palette='magma')
            ax.set_title(f'Average {num_col} by {cat_col}')
            ax.set_xlabel(f'Average {num_col}')
            ax.set_ylabel(cat_col)
            save_plot(fig, f'avg_{num_col}_by_{cat_col}')

# 7. Countplot showing relationship between two categorical variables if possible
if len(cat_cols) >= 2:
    cat1 = cat_cols[0]
    cat2 = cat_cols[1]
    fig, ax = plt.subplots(figsize=(12,8))
    sns.countplot(data=df, x=cat1, hue=cat2, ax=ax, palette='Set2')
    ax.set_title(f'Countplot of {cat1} grouped by {cat2}')
    plt.xticks(rotation=45)
    save_plot(fig, f'countplot_{cat1}_by_{cat2}')

print(f"Visualizations created and saved to the '{output_dir}' directory.")
