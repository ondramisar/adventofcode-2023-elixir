defmodule AdventOfCode.Day01 do
  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(0, fn row, count ->
      row
      |> String.replace(~r|\D|, "", global: true)
      |> String.codepoints()
      |> IO.inspect(label: "After split")
      |> (fn
            [first | []] -> String.to_integer("#{first}#{first}")
            [first | rest] -> String.to_integer("#{first}#{Enum.at(rest, -1)}")
          end).()
      |> IO.inspect(label: "After format")
      |>  Kernel.+(count)
    end)
    |> IO.inspect(label: "After reduce")
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&extract_calibration_value/1)
    |> Enum.reduce(0, &(&1 + &2))
  end

  defp extract_calibration_value(line) do
    {first_digit, last_digit} =
      line
      |> String.graphemes()
      |> Enum.chunk_every(1, 1, :discard)
      |> Enum.filter(&is_digit/1)
      |> Enum.map(&String.to_integer/1)

    first_digit * 10 + last_digit
  end

  defp is_digit(grapheme) do
    String.match?(grapheme, ~r/\d+/)
  end
end
