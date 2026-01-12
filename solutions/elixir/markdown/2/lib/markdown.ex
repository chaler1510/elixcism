defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

      iex> Markdown.parse("This is a paragraph")
      "<p>This is a paragraph</p>"

      iex> Markdown.parse("# Header!\\n* __Bold Item__\\n* _Italic Item_")
      "<h1>Header!</h1><ul><li><strong>Bold Item</strong></li><li><em>Italic Item</em></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(markdown) do
    markdown
    |> String.split("\n")
    |> Enum.map(&process/1)
    |> Enum.join()
    |> patch
  end

  @spec process(String.t()) :: [String.t()]
  defp process(text) do
    cond do
      String.starts_with?(text, "#") && !String.starts_with?(text, "#######") ->
        text
        |> parse_header_md_level
        |> enclose_with_header_tag

      String.starts_with?(text, "*") ->
        parse_list_md_level(text)

      true ->
        text
        |> String.split()
        |> enclose_with_paragraph_tag
    end
  end

  @spec parse_header_md_level(String.t()) :: {String.t(), String.t()}
  defp parse_header_md_level(header_with_text) do
    [header | words_list] = String.split(header_with_text)
    header_level = header |> String.length() |> to_string
    text = words_list |> Enum.join(" ")
    {header_level, text}
  end

  @spec parse_list_md_level([String.t()]) :: String.t()
  defp parse_list_md_level(list) do
    text =
      list
      |> String.trim_leading("* ")
      |> String.split()

    "<li>" <> join_words_with_tags(text) <> "</li>"
  end

  @spec enclose_with_header_tag({String.t(), String.t()}) :: String.t()
  defp enclose_with_header_tag({header_level, text}) do
    "<h" <> header_level <> ">" <> text <> "</h" <> header_level <> ">"
  end

  @spec enclose_with_paragraph_tag([String.t()]) :: String.t()
  defp enclose_with_paragraph_tag(words_list) do
    "<p>#{join_words_with_tags(words_list)}</p>"
  end

  @spec join_words_with_tags([String.t()]) :: String.t()
  defp join_words_with_tags(words_list) do
    words_list
    |> Enum.map(&replace_md_with_tag/1)
    |> Enum.join(" ")
  end

  @spec replace_md_with_tag(String.t()) :: String.t()
  defp replace_md_with_tag(word) do
    word
    |> replace_prefix_md
    |> replace_suffix_md
  end

  @spec replace_prefix_md(String.t()) :: String.t()
  defp replace_prefix_md("__" <> rest), do: "<strong>" <> rest
  defp replace_prefix_md("_" <> rest), do: "<em>" <> rest
  defp replace_prefix_md(word), do: word

  @spec replace_suffix_md(String.t()) :: String.t()
  defp replace_suffix_md(word) do
    cond do
      String.ends_with?(word, "__") ->
        String.slice(word, 0, String.length(word) - 2) <> "</strong>"

      String.ends_with?(word, "_") ->
        String.slice(word, 0, String.length(word) - 1) <> "</em>"

      true ->
        word
    end
  end
  
@doc """
  In Markdown, list items always appear consecutively.
  This function wraps a continuous sequence of
  <li>...</li> elements in <ul>...</ul> tags.

  Example: "<li>Item 1</li><li>Item 2</li>"
  → "<ul><li>Item 1</li><li>Item 2</li></ul>"

  Greedy matching finds from the first <li> to the last </li>
  which corresponds to the entire block of list items in Markdown  
"""
@spec parse(String.t()) :: String.t()
defp patch(html) do
  if String.contains?(html, "<li>") do
    Regex.replace(~r/(<li>.*<\/li>)/s, html, "<ul>\\1</ul>")
  else
    html
  end
end
end
