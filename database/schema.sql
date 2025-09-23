-- =========================================================
-- Pokémon Card Collection Database Schema
-- =========================================================
CREATE DATABASE IF NOT EXISTS pokemon;
USE pokemon;

DROP TABLE IF EXISTS user_cards;
DROP TABLE IF EXISTS cards;
DROP TABLE IF EXISTS users;


CREATE TABLE users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    join_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE cards (
    card_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    set_name VARCHAR(100) NOT NULL,
    number_in_set VARCHAR(10),  
    rarity VARCHAR(50),
    type VARCHAR(50),            
    hp INT,
    release_year INT,
    image_url VARCHAR(255)
);


CREATE TABLE user_cards (
    user_card_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    card_id INT NOT NULL,
    quantity INT DEFAULT 1,
    card_condition ENUM('Mint', 'Near Mint', 'Good', 'Played', 'Poor') DEFAULT 'Good',
    is_holo BOOLEAN DEFAULT FALSE,
    notes TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (card_id) REFERENCES cards(card_id) ON DELETE CASCADE,
    UNIQUE (user_id, card_id, card_condition, is_holo)
);


INSERT INTO cards (name, set_name, number_in_set, rarity, type, hp, release_year, image_url)
VALUES
('Alakazam', 'Base Set', '1/102', 'Rare Holo', 'Psychic', 80, 1999, 'https://pkmncards.com/wp-content/uploads/alakazam-base-set-bs-1.jpg'),
('Blastoise', 'Base Set', '2/102', 'Rare Holo', 'Water', 100, 1999, 'https://pkmncards.com/wp-content/uploads/blastoise-base-set-bs-2.jpg'),
('Chansey', 'Base Set', '3/102', 'Rare Holo', 'Colorless', 250, 1999, 'https://pkmncards.com/wp-content/uploads/chansey-base-set-bs-3.jpg'),
('Charizard', 'Base Set', '4/102', 'Rare Holo', 'Fire', 120, 1999, 'https://pkmncards.com/wp-content/uploads/charizard-base-set-bs-4.jpg'),
('Clefairy', 'Base Set', '5/102', 'Rare Holo', 'Colorless', 60, 1999, 'https://pkmncards.com/wp-content/uploads/clefairy-base-set-bs-5.jpg'),
('Gyarados', 'Base Set', '6/102', 'Rare Holo', 'Water', 100, 1999, 'https://pkmncards.com/wp-content/uploads/gyarados-base-set-bs-6.jpg'),
('Hitmonchan', 'Base Set', '7/102', 'Rare Holo', 'Fighting', 70, 1999, 'https://pkmncards.com/wp-content/uploads/hitmonchan-base-set-bs-7.jpg'),
('Machamp', 'Base Set', '8/102', 'Rare Holo', 'Fighting', 100, 1999, 'https://pkmncards.com/wp-content/uploads/machamp-base-set-bs-8.jpg'),
('Magneton', 'Base Set', '9/102', 'Rare Holo', 'Lightning', 60, 1999, 'https://pkmncards.com/wp-content/uploads/magneton-base-set-bs-9.jpg'),
('Mewtwo', 'Base Set', '10/102', 'Rare Holo', 'Psychic', 60, 1999, 'https://pkmncards.com/wp-content/uploads/mewtwo-base-set-bs-10.jpg'),
('Nidoking', 'Base Set', '11/102', 'Rare Holo', 'Poison', 90, 1999, 'https://pkmncards.com/wp-content/uploads/nidoking-base-set-bs-11.jpg'),
('Ninetales', 'Base Set', '12/102', 'Rare Holo', 'Fire', 70, 1999, 'https://pkmncards.com/wp-content/uploads/ninetales-base-set-bs-12.jpg'),
('Poliwrath', 'Base Set', '13/102', 'Rare Holo', 'Water', 90, 1999, 'https://pkmncards.com/wp-content/uploads/poliwrath-base-set-bs-13.jpg'),
('Raichu', 'Base Set', '14/102', 'Rare Holo', 'Lightning', 60, 1999, 'https://pkmncards.com/wp-content/uploads/raichu-base-set-bs-14.jpg'),
('Venusaur', 'Base Set', '15/102', 'Rare Holo', 'Grass', 100, 1999, 'https://pkmncards.com/wp-content/uploads/venusaur-base-set-bs-15.jpg'),
('Zapdos', 'Base Set', '16/102', 'Rare Holo', 'Lightning', 90, 1999, 'https://pkmncards.com/wp-content/uploads/zapdos-base-set-bs-16.jpg'),
('Beedrill', 'Base Set', '17/102', 'Rare', 'Bug', 60, 1999, 'https://pkmncards.com/wp-content/uploads/beedrill-base-set-bs-17.jpg'),
('Dragonair', 'Base Set', '18/102', 'Rare', 'Colorless', 80, 1999, 'https://pkmncards.com/wp-content/uploads/dragonair-base-set-bs-18.jpg'),
('Dugtrio', 'Base Set', '19/102', 'Rare', 'Fighting', 70, 1999,'https://pkmncards.com/wp-content/uploads/dugtrio-base-set-bs-19.jpg'),
('Electabuzz', 'Base Set', '20/102', 'Rare', 'Lightning', 70, 1999, 'https://pkmncards.com/wp-content/uploads/electabuzz-base-set-bs-20.jpg'),
('Electrode', 'Base Set', '21/102', 'Rare', 'Lightning', 80, 1999, 'https://pkmncards.com/wp-content/uploads/electrode-base-set-bs-21.jpg'),
('Pidgeotto', 'Base Set', '22/102', 'Uncommon', 'Normal', 60, 1999, 'https://pkmncards.com/wp-content/uploads/pidgeotto-base-set-bs-22.jpg'),
('Arcanine', 'Base Set', '23/102', 'Uncommon', 'Fire', 100, 1999, 'https://pkmncards.com/wp-content/uploads/arcanine-base-set-bs-23.jpg'),
('Charmeleon', 'Base Set', '24/102', 'Uncommon', 'Fire', 80, 1999, 'https://pkmncards.com/wp-content/uploads/charmeleon-base-set-bs-24.jpg'),
('Dewgong', 'Base Set', '25/102', 'Uncommon', 'Water', 80, 1999, 'https://pkmncards.com/wp-content/uploads/dewgong-base-set-bs-25.jpg'),
('Dratini', 'Base Set', '26/102', 'Uncommon', 'Colorless', 40, 1999, 'https://pkmncards.com/wp-content/uploads/dratini-base-set-bs-26.jpg'),
('Farfetchd', 'Base Set', '27/102', 'Uncommon', 'Colorless', 50, 1999, 'https://pkmncards.com/wp-content/uploads/farfetchd-base-set-bs-27.jpg'),
('Growlithe', 'Base Set', '28/102', 'Uncommon', 'Fire', 60, 1999, 'https://pkmncards.com/wp-content/uploads/growlithe-base-set-bs-28.jpg'),
('Haunter', 'Base Set', '29/102', 'Uncommon', 'Psychic', 60, 1999, 'https://pkmncards.com/wp-content/uploads/haunter-base-set-bs-29.jpg'),
('Ivysaur', 'Base Set', '30/102', 'Uncommon', 'Grass', 60, 1999, 'https://pkmncards.com/wp-content/uploads/ivysaur-base-set-bs-30.jpg'),
('Jynx', 'Base Set', '31/102', 'Uncommon', 'Psychic', 70, 1999, 'https://pkmncards.com/wp-content/uploads/jynx-base-set-bs-31.jpg'),
('Kadabra', 'Base Set', '32/102', 'Uncommon', 'Psychic', 60, 1999, 'https://pkmncards.com/wp-content/uploads/kadabra-base-set-bs-32.jpg'),
('Kakuna', 'Base Set', '33/102', 'Uncommon', 'Grass', 80, 1999, 'https://pkmncards.com/wp-content/uploads/kakuna-base-set-bs-33.jpg'),
('Machoke', 'Base Set', '34/102', 'Uncommon', 'Fighting', 80, 1999, 'https://pkmncards.com/wp-content/uploads/machoke-base-set-bs-34.jpg'),
('Magikarp', 'Base Set', '35/102', 'Uncommon', 'Water', 30, 1999, 'https://pkmncards.com/wp-content/uploads/magikarp-base-set-bs-35.jpg'),
('Magmar', 'Base Set', '36/102', 'Uncommon', 'Fire', 50, 1999, 'https://pkmncards.com/wp-content/uploads/magmar-base-set-bs-36.jpg'),
('Nidorino', 'Base Set', '37/102', 'Uncommon', 'Grass', 60, 1999, 'https://pkmncards.com/wp-content/uploads/nidorino-base-set-bs-37.jpg'),
('Poliwhirl', 'Base Set', '38/102', 'Uncommon', 'Water', 60, 1999, 'https://pkmncards.com/wp-content/uploads/poliwhirl-base-set-bs-38.jpg'),
('Porygon', 'Base Set', '39/102', 'Uncommon', 'Colorless', 30, 1999, 'https://pkmncards.com/wp-content/uploads/porygon-base-set-bs-39.jpg'),
('Raticate', 'Base Set', '40/102', 'Uncommon', 'Normal', 60, 1999, 'https://pkmncards.com/wp-content/uploads/raticate-base-set-bs-40.jpg'),
('Seel', 'Base Set', '41/102', 'Uncommon', 'Water', 60, 1999, 'https://pkmncards.com/wp-content/uploads/seel-base-set-bs-41.jpg'),
('Wartortle', 'Base Set', '42/102', 'Uncommon', 'Water', 70, 1999, 'https://pkmncards.com/wp-content/uploads/wartortle-base-set-bs-42.jpg'),
('Abra', 'Base Set', '43/102', 'Common', 'Psychic', 30, 1999, 'https://pkmncards.com/wp-content/uploads/abra-base-set-bs-43.jpg'),
('Bulbasaur', 'Base Set', '44/102', 'Common', 'Grass', 40, 1999, 'https://pkmncards.com/wp-content/uploads/bulbasaur-base-set-bs-44.jpg'),
('Caterpie', 'Base Set', '45/102', 'Common', 'Grass', 40, 1999, 'https://pkmncards.com/wp-content/uploads/caterpie-base-set-bs-45.jpg'),
('Charmander', 'Base Set', '46/102', 'Common', 'Fire', 50, 1999, 'https://pkmncards.com/wp-content/uploads/charmander-base-set-bs-46.jpg'),
('Diglett', 'Base Set', '47/102', 'Common', 'Fighting', 30, 1999, 'https://pkmncards.com/wp-content/uploads/diglett-base-set-bs-47.jpg'),
('Doduo', 'Base Set', '48/102', 'Common', 'Normal', 50, 1999, 'https://pkmncards.com/wp-content/uploads/doduo-base-set-bs-48.jpg'),
('Drowzee', 'Base Set', '49/102', 'Common', 'Psychic', 50, 1999, 'https://pkmncards.com/wp-content/uploads/drowzee-base-set-bs-49.jpg'),
('Gastly', 'Base Set', '50/102', 'Common', 'Psychic', 30, 1999, 'https://pkmncards.com/wp-content/uploads/gastly-base-set-bs-50.jpg'),
('Koffing', 'Base Set', '51/102', 'Common', 'Grass', 50, 1999, 'https://pkmncards.com/wp-content/uploads/koffing-base-set-bs-51.jpg'),
('Machop', 'Base Set', '52/102', 'Common', 'Fighting', 50, 1999, 'https://pkmncards.com/wp-content/uploads/machop-base-set-bs-52.jpg'),
('Magnemite', 'Base Set', '53/102', 'Common', 'Lightning', 40, 1999, 'https://pkmncards.com/wp-content/uploads/magnemite-base-set-bs-53.jpg'),
('Metapod', 'Base Set', '54/102', 'Common', 'Grass', 70, 1999, 'https://pkmncards.com/wp-content/uploads/metapod-base-set-bs-54.jpg'),
('Nidoran', 'Base Set', '55/102', 'Common', 'Grass', 40, 1999, 'https://pkmncards.com/wp-content/uploads/nidoran-male-base-set-bs-55.jpg'),
('Onix', 'Base Set', '56/102', 'Common', 'Fighting', 90, 1999, 'https://pkmncards.com/wp-content/uploads/onix-base-set-bs-56.jpg'),
('Pidgey', 'Base Set', '57/102', 'Common', 'Colorless', 40, 1999, 'https://pkmncards.com/wp-content/uploads/pidgey-base-set-bs-57.jpg'),
('Pikachu', 'Base Set', '58/102', 'Common', 'Lightning', 40, 1999, 'https://pkmncards.com/wp-content/uploads/pikachu-base-set-bs-58.jpg'),
('Poliwag', 'Base Set', '59/102', 'Common', 'Water', 40, 1999, 'https://pkmncards.com/wp-content/uploads/poliwag-base-set-bs-59.jpg'),
('Ponyta', 'Base Set', '60/102', 'Common', 'Fire', 40, 1999, 'https://pkmncards.com/wp-content/uploads/ponyta-base-set-bs-60.jpg'),
('Rattata', 'Base Set', '61/102', 'Common', 'Colorless', 30, 1999, 'https://pkmncards.com/wp-content/uploads/rattata-base-set-bs-61.jpg'),
('Sandshrew', 'Base Set', '62/102', 'Common', 'Fighting', 40, 1999, 'https://pkmncards.com/wp-content/uploads/sandshrew-base-set-bs-62.jpg'),
('Squirtle', 'Base Set', '63/102', 'Common', 'Water', 40, 1999, 'https://pkmncards.com/wp-content/uploads/squirtle-base-set-bs-63.jpg'),
('Starmie', 'Base Set', '64/102', 'Common', 'Water', 60, 1999, 'https://pkmncards.com/wp-content/uploads/starmie-base-set-bs-64.jpg'),
('Staryu', 'Base Set', '65/102', 'Common', 'Water', 40, 1999, 'https://pkmncards.com/wp-content/uploads/staryu-base-set-bs-65.jpg'),
('Tangela', 'Base Set', '66/102', 'Common', 'Grass', 50, 1999, 'https://pkmncards.com/wp-content/uploads/tangela-base-set-bs-66.jpg'),
('Voltorb', 'Base Set', '67/102', 'Common', 'Lightning', 40, 1999, 'https://pkmncards.com/wp-content/uploads/voltorb-base-set-bs-67.jpg'),
('Vulpix', 'Base Set', '68/102', 'Common', 'Fire', 50, 1999, 'https://pkmncards.com/wp-content/uploads/vulpix-base-set-bs-68.jpg'),
('Weedle', 'Base Set', '69/102', 'Common', 'Grass', 40, 1999, 'https://pkmncards.com/wp-content/uploads/weedle-base-set-bs-69.jpg'),
('Clefairy Doll', 'Base Set', '70/102', 'Trainer', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/clefairy-doll-base-set-bs-70.jpg'),
('Computer Search', 'Base Set', '71/102', 'Trainer', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/computer-search-base-set-bs-71.jpg'),
('Devolution Spray', 'Base Set', '72/102', 'Trainer', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/devolution-spray-base-set-bs-72.jpg'),
('Imposter Professor Oak', 'Base Set', '73/102', 'Trainer', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/impostor-professor-oak-base-set-bs-73.jpg'),
('Item Finder', 'Base Set', '74/102', 'Trainer', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/item-finder-base-set-bs-74.jpg'),
('Lass', 'Base Set', '75/102', 'Trainer', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/lass-base-set-bs-75.jpg'),
('Pokémon Breeder', 'Base Set', '76/102', 'Trainer', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/pokemon-breeder-base-set-bs-76.jpg'),
('Pokémon Trader', 'Base Set', '77/102', 'Trainer', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/pokemon-trader-base-set-bs-77.jpg'),
('Scoop Up', 'Base Set', '78/102', 'Trainer', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/scoop-up-base-set-bs-78.jpg'),
('Super Energy Removal', 'Base Set', '79/102', 'Trainer', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/super-energy-removal-base-set-bs-79.jpg'),
('Defender', 'Base Set', '80/102', 'Trainer', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/defender-base-set-bs-80.jpg'),
('Energy Retrieval', 'Base Set', '81/102', 'Trainer', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/energy-retrieval-base-set-bs-81.jpg'),
('Full Heal', 'Base Set', '82/102', 'Trainer', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/full-heal-base-set-bs-82.jpg'),
('Maintenance', 'Base Set', '83/102', 'Trainer', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/maintenance-base-set-bs-83.jpg'),
('PlusPower', 'Base Set', '84/102', 'Trainer', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/pluspower-base-set-bs-84.jpg'),
('Pokémon Center', 'Base Set', '85/102', 'Trainer', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/pokemon-center-base-set-bs-85.jpg'),
('Pokémon Flute', 'Base Set', '86/102', 'Trainer', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/pokemon-flute-base-set-bs-86.jpg'),
('Pokédex', 'Base Set', '87/102', 'Trainer', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/pokedex-base-set-bs-87.jpg'),
('Professor Oak', 'Base Set', '88/102', 'Trainer', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/professor-oak-base-set-bs-88.jpg'),
('Revive', 'Base Set', '89/102', 'Trainer', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/revive-base-set-bs-89.jpg'),
('Super Potion', 'Base Set', '90/102', 'Trainer', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/super-potion-base-set-bs-90.jpg'),
('Bill', 'Base Set', '91/102', 'Trainer', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/bill-base-set-bs-91.jpg'),
('Energy Removal', 'Base Set', '92/102', 'Trainer', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/energy-removal-base-set-bs-92.jpg'),
('Gust of Wind', 'Base Set', '93/102', 'Trainer', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/gust-of-wind-base-set-bs-93.jpg'),
('Potion', 'Base Set', '94/102', 'Trainer', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/potion-base-set-bs-94.jpg'),
('Switch', 'Base Set', '95/102', 'Trainer', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/switch-base-set-bs-95.jpg'),
('Double Colorless Energy', 'Base Set', '96/102', 'Energy', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/double-colorless-energy-base-set-bs-96.jpg'),
('Fighting Energy', 'Base Set', '97/102', 'Energy', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/fighting-energy-base-set-bs-97.jpg'),
('Fire Energy', 'Base Set', '98/102', 'Energy', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/fire-energy-base-set-bs-98.jpg'),
('Grass Energy', 'Base Set', '99/102', 'Energy', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/grass-energy-base-set-bs-99.jpg'),
('Lightning Energy', 'Base Set', '100/102', 'Energy', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/lightning-energy-base-set-bs-100.jpg'),
('Psychic Energy', 'Base Set', '101/102', 'Energy', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/psychic-energy-base-set-bs-101.jpg'),
('Water Energy', 'Base Set', '102/102', 'Energy', NULL, NULL, 1999, 'https://pkmncards.com/wp-content/uploads/water-energy-base-set-bs-102.jpg');

