# LateX tips
## Using `ttfamily` with `bfseries` in a listing
Default font doesn't implement bold style:
```latex
\renewcommand{\ttdefault}{pcr}
\begin{lstlisting}[basicstyle=\ttfamily\bfseries]
y:=2
\end{lstlisting}
```
