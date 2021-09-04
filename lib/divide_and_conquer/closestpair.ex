defmodule ClosestPair do
  def find(p) do
    px = Enum.sort_by(p, &elem(&1, 0))
    py = Enum.sort_by(p, &elem(&1, 1))
    _find(px, py)
  end

  def dist([{x1, y1}, {x2, y2}]) do
    :math.sqrt(:math.pow(x1 - x2, 2) + :math.pow(y1 - y2, 2))
  end

  def _find(px, _) when length(px) == 2 do
    dist(px)
  end

  def _find(px, py) do
    mid = round(length(px) / 2)
    [px_left, px_right] = Enum.chunk_every(px, mid, mid, [])
    [py_left, py_right] = Enum.chunk_every(px, mid, mid, [])

    d_left = _find(px_left, py_left)
    d_right = _find(px_right, py_right)
    d = min(d_left, d_right)

    {ps, d} = _find_split(px, py, d, List.last(px_left))
  end

  def _find_split(px, py, d, {median, _}) do
    in_range? = fn {x, y} -> x > median_x - d and x < median_x + d end
    sy = for {x, y} <- py, in_range?.({x, y}), do: {x, y}

    Enum.map(
      sy,
    )
  end
end
