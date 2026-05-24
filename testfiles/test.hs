import Data.Text
import Faker
import Faker.Address
import Faker.Name

asdf

data Person = Person
    { personName :: Text
    , personAddress :: Text
    }
    deriving (Show, Eq)

fakePerson :: Fake Person
fakePerson = do
    personName <- name
    personAddress <- fullAddress
    pure $ Person{..}

main :: IO ()
main = do
    person <- generate fakePerson
    print person
