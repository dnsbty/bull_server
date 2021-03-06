defmodule BullServer.Games.Words do
  @moduledoc """
  A list of words and definitions from which to take random words to be defined.
  """
  @words %{
    "acrocephalic" => "A person suffering from a pointed skull",
    "ailurophile" => "One who loves cats",
    "allocochick" => "Indian shell-money used in northern California",
    "aprosexia" => "Inability to concentrate",
    "baronduki" => "A terrestrial Siberian squirrel",
    "bathetic" => "Effusively or insincerely emotional",
    "biggin" => "A child's cap",
    "bipennis" => "An axe with an edge or blade on each side of the handle",
    "bissextile" => "A year having an extra day",
    "blennophobia" => "The irrational fear of slim",
    "bletting" => "A fermentation process in certain fruit beyond ripening",
    "bufagin" => "A toxic steroid",
    "bundobust" => "A system or discipline",
    "bunji-bunji" => "An Australian tree with poisonous bark",
    "cannelure" => "A groove around the cylinder of a bullet",
    "carriwitchet" => "An absurd question",
    "choil" => "An unsharpened section of a knife blade",
    "cisvestism" => "The wearing of clothing that does not represent one's profession or status",
    "cockchafer" => "European beetles that destroy plants",
    "coom" => "Soot, dust, or grease",
    "coprolite" => "Fossilized excrement",
    "crawthumper" => "An overly religious person",
    "crizzle" => "To roughen on the surface",
    "deasil" => "Following the direction of the sun's movement",
    "deipnophobia" => "The fear of dinner parties",
    "didunculus" => "A family of pigeons",
    "doromania" => "An unusual urge to give gifts",
    "drapetomania" => "An overwhelming urge to run away",
    "dunga-runga" => "A small, crooked tree",
    "emacity" => "Desire or fondness for buying",
    "emunction" => "The act of blowing one's nose",
    "exophagy" => "A custom of certain cannibal tribes, prohibiting the eating of persons of their own tribe",
    "fackeltanz" => "A torchlight procession associated with German royal wedding celebrations",
    "fardingbag" => "The upper stomach of a cow",
    "fartlek" => "An athletic training technique in which strenuous effort and normal effort alternate",
    "ferdwit" => "A fine imposed for not embarking in a military expedition",
    "fezzle" => "A litter of pigs",
    "fiants" => "The dung of the fox, wolf, boar, or badger",
    "fichu" => "A woman's lightweight triangular scarf worn over the shoulders and tied in front",
    "fizzog" => "The face",
    "flews" => "The flaps of skin hanging from the side of the lips of hounds",
    "fluther" => "In a hurry",
    "frenulum" => "A small fold of tissue that prevents an organ in the body from moving too far",
    "fud" => "The tail of a hare",
    "fumet" => "Concentrated food stock that is added to sauces to enhance their flavor",
    "furfur" => "A particle of dandruff",
    "furfural" => "A fungicide and weed killer made from corncobs",
    "furuncle" => "A boil or infected, inflamed, pus-filled sore",
    "fyrdung" => "A military expedition",
    "gaberlunzie" => "A licenced beggar",
    "gaffle" => "A lever used to bend a crossbow",
    "galactophagist" => "One who eats or subsists on milk",
    "ghurry" => "A clock or other timepiece",
    "ginglymus" => "A hinge joint",
    "glabrescent" => "Becoming hairless or smooth",
    "gutta-percha" => "A natural latex produced from the sap of tropical trees",
    "hackmatack" => "A tree with heart-shaped leaves",
    "hagbut" => "A firearm with a long barrel",
    "haptodysphoria" => "The sensation felt when handling fuzzy surfaces",
    "haruspicy" => "The study and divination by use of animal entrails",
    "hawsehole" => "The hole through which a ship's anchor rope is passed",
    "hodmandod" => "A snail",
    "howdah" => "A seat, usually with a canopy, carried on the back of an elephant or camel",
    "koomkie" => "A tame female elephant used as a decoy in the capture of wild male elephants",
    "jipijapa" => "A Central American plant with long leaves used for making hats",
    "jollop" => "A strong liquor or medicine",
    "kakkerlak" => "A cockroach",
    "kamalayka" => "A waterproof shirt made of intestines of seal or walrus",
    "liripoop" => "A scarf typically worn by doctors and learned men",
    "lychnobite" => "A person who works or labors at night and sleeps during the day",
    "mamamouchi" => "A pompous title",
    "mehari" => "A fast-running camel",
    "melanotrichous" => "Having black hair",
    "miryachit" => "A nervous disease that causes you to mimic another person",
    "morpunkee" => "A native Indian river boat often used for state occasions",
    "musnud" => "A seat with a cushion used as a throne by Indian princes",
    "myomancy" => "Predicting the future based on the movements of mice",
    "natterjack" => "A European toad known for its very loud mating call",
    "niblick" => "A metal golf club used to lift the ball out of holes",
    "nurdle" => "To muse on a subject which one clearly knows little about",
    "omphaloskepsis" => "Contemplation of one's navel",
    "otolith" => "A small particle in the ear that helps with balance",
    "ozostomia" => "Terrible breath",
    "pahoehoe" => "Lava with a smooth ropy surface",
    "philtrum" => "The shallow groove running down the center of the outer surface of the upper lip",
    "piblockto" => "A frenzied condition of dogs which results from continued exposure to extremely cold weather",
    "plumbum" => "The technical name of lead",
    "pogonip" => "A dense ice fog which forms in valleys",
    "pogonophile" => "One who loves or studies beards",
    "pogonotomy" => "The cutting of beards",
    "prunella" => "A strong, heavy fabric used for shoes, robes, and gowns",
    "pungi" => "A Hindu pipe or nose-flute commonly used by snake charmers",
    "quipu" => "A recording device, used by the Incas, consisting of intricate knotted cords",
    "ranarium" => "A place where frogs are bred",
    "rupophobia" => "Fear of uncleanliness",
    "sarcology" => "The study of the soft parts of the body",
    "satrap" => "A governor of a province in ancient Persia",
    "schemozzle" => "A confused situation or affair",
    "scopula" => "A dense tuft of hair, as on certain insects legs",
    "sessle" => "To change seats very often",
    "sexfoil" => "A plant or flower with six leaves",
    "sialogogue" => "Any drug that increases the flow of saliva",
    "sigogglin" => "Crookedly built",
    "silybum" => "A family of east African herbs",
    "smuth" => "Miners' name for undesirable coal",
    "snast" => "The burnt wick of a candle",
    "sniddle" => "Long coarse grass",
    "sniggle" => "To catch an eel by thrusting a baited hook into its den",
    "snotter" => "To snivel, cry, or whine",
    "soogee-moogee" => "A type of strong cleaning product for wood and paint on board a boat",
    "soosoo" => "An Indian dolphin with a beak shaped like a spatula",
    "soushumber" => "A noxious weed with pear-shaped berries",
    "sozzle" => "One who spills water or other liquids carelessly",
    "spizzerinctum" => "Determination",
    "spong" => "A long and narrow piece of land, resembling a tongue",
    "spraints" => "The dung of an otter",
    "sprog" => "A child",
    "stadda" => "A doublebladed hand-saw",
    "swallet" => "Water breaking in upon miners at work",
    "swazzle" => "Device to change the voice to make it more raspy",
    "swow" => "To swear a mild oath",
    "tarantism" => "An extreme urge to dance",
    "tegestologist" => "someone who collects beer mats or coasters",
    "timbromania" => "A passion for stamp collecting",
    "tittup" => "To prance or frolic",
    "totipalmation" => "Full webbing of a bird's foot",
    "twankay" => "A Chinese green tea",
    "tzitzit" => "The knotted fringes of a traditional Jewish prayer shawl",
    "ugli" => "A cross between a tangerine and grapefruit",
    "warkamoowee" => "A canoe with outriggers",
    "whickflaw" => "Swelling around the fingernails",
    "whiffler" => "One who frequently changes their opinion or course",
    "whizzer" => "A centrifugal machine used for drying sugar, grain, clothes, etc.",
    "wonga-wonga" => "A large, white Australian pigeon",
    "woom" => "The fur of a beaver",
    "xylivorous" => "Wood-eating",
    "yapok" => "An aquatic opossum",
    "zamouse" => "A West African buffalo with short horns and large ears",
    "zarf" => "An ornamental container designed to hold a hot coffee cup",
    "zenzizenzizenzic" => "The eighth power of a number",
    "zobo" => "Asian cattle, hybrid between the zebu and the yak",
    "zoster" => "A belt worn by men in ancient Greece",
    "zufolo" => "A little flute used to teach birds",
    "zugzwang" => "A situation in chess in which a player is forced to make a move",
    "zumbooruk" => "A small cannon mounted on a swivel",
    "zyzzyva" => "American weevil that destroys plants"
  }

  @doc """
  Returns the definition for the specified word if it's defined, or nil if it isn't.

  ## Examples

      iex> define("zyzzyva")
      "American weevil that destroys plants"

      iex> define("sdlkfj")
      nil
  """
  @spec define(word :: String.t) :: String.t | nil
  def define(word) do
    @words[word]
  end

  @doc """
  Get a random word from the list.

      iex> random()
      {"zyzzyva", "American weevil that destroys plants"}
  """
  @spec random() :: {String.t, String.t}
  def random do
    Enum.random(@words)
  end
end
