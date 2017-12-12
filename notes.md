# <td class="bold">100.</td><td>
#     <span class="tMeterIcon tiny">
#                 <span class="icon tiny certified_fresh"></span>
#                 <span class="tMeterScore"> 100%</span>
#             </span>
#         </td><td>
#     <a href="/m/grapes_of_wrath" class="unstyled articleLink">
#         The Grapes of Wrath (1940)</a>
# </td><td class="right hidden-xs">43</td>

# cells.each do |cell|
#   puts "#{cell.search(".bold").text.strip}"
#   puts "#{cell.search(".tMeterScore").text.strip}" # Extracts RT scores
#   puts "#{cell.search(".unstyled").text.strip}" # Extracts Movie Name
#   cell.search("a").each {|link| puts "#{link['href']}"} # Extracts URL
# end
