SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `menu_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `menu_items` (
  `item_id` INT NOT NULL,
  `item_name` VARCHAR(45) NULL,
  `category` VARCHAR(45) NULL,
  `price` DECIMAL(4,2) NULL,
  PRIMARY KEY (`item_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `employee` (
  `employee_id` INT NOT NULL,
  `f_name` VARCHAR(45) NULL,
  `l_name` VARCHAR(45) NULL,
  `position` VARCHAR(45) NULL,
  `hire_date` DATE NULL,
  PRIMARY KEY (`employee_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `orders` (
  `order_id` INT NOT NULL,
  `order_date` DATE NULL,
  `total_amount` VARCHAR(45) NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_orders_employee1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory` (
  `ingredient_id` INT NOT NULL,
  `ingredient_name` VARCHAR(45) NULL,
  `ingredient_cost` VARCHAR(45) NULL,
  `ingredient_amount` VARCHAR(45) NULL,
  PRIMARY KEY (`ingredient_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `supplier` (
  `supplier_id` INT NOT NULL,
  `s_name` VARCHAR(45) NULL,
  `s_contact` VARCHAR(45) NULL,
  `phone_number` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `ingredient_id` INT NOT NULL,
  PRIMARY KEY (`supplier_id`),
  INDEX `fk_supplier_inventory1_idx` (`ingredient_id` ASC) VISIBLE,
  CONSTRAINT `fk_supplier_inventory1`
    FOREIGN KEY (`ingredient_id`)
    REFERENCES `inventory` (`ingredient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shifts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shifts` (
  `shift_id` INT NOT NULL,
  `shift_date` VARCHAR(45) NULL,
  `start_time` VARCHAR(45) NULL,
  `end_time` VARCHAR(45) NULL,
  `shift_type` VARCHAR(45) NULL,
  PRIMARY KEY (`shift_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shift_assignments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shift_assignments` (
  `assignment_id` INT NOT NULL,
  PRIMARY KEY (`assignment_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `order_item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `order_item` (
  `order_item_id` INT NOT NULL,
  PRIMARY KEY (`order_item_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `completed_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `completed_order` (
  `item_id` INT NOT NULL,
  `orders_id` INT NOT NULL,
  `completed_order_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`item_id`, `orders_id`, `completed_order_id`),
  INDEX `fk_menu_items_has_orders_orders1_idx` (`orders_id` ASC) VISIBLE,
  INDEX `fk_menu_items_has_orders_menu_items_idx` (`item_id` ASC) VISIBLE,
  CONSTRAINT `fk_menu_items_has_orders_menu_items`
    FOREIGN KEY (`item_id`)
    REFERENCES `menu_items` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_items_has_orders_orders1`
    FOREIGN KEY (`orders_id`)
    REFERENCES `orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `shift_assignment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shift_assignment` (
  `shift_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  `shift_assignment_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`shift_id`, `employee_id`, `shift_assignment_id`),
  INDEX `fk_shifts_has_employee_employee1_idx` (`employee_id` ASC) VISIBLE,
  INDEX `fk_shifts_has_employee_shifts1_idx` (`shift_id` ASC) VISIBLE,
  CONSTRAINT `fk_shifts_has_employee_shifts1`
    FOREIGN KEY (`shift_id`)
    REFERENCES `shifts` (`shift_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shifts_has_employee_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recipe_ingredients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `recipe_ingredients` (
  `ingredient_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  `recipe_id` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ingredient_id`, `item_id`, `recipe_id`),
  INDEX `fk_inventory_has_menu_items_menu_items1_idx` (`item_id` ASC) VISIBLE,
  INDEX `fk_inventory_has_menu_items_inventory1_idx` (`ingredient_id` ASC) VISIBLE,
  CONSTRAINT `fk_inventory_has_menu_items_inventory1`
    FOREIGN KEY (`ingredient_id`)
    REFERENCES `inventory` (`ingredient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventory_has_menu_items_menu_items1`
    FOREIGN KEY (`item_id`)
    REFERENCES `menu_items` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;




-- ===============================
-- MENU ITEMS
-- -------------------------------
INSERT INTO menu_items (item_id, item_name, category, price) VALUES
  (1, 'Espresso', 'Coffee', 2.50),
  (2, 'Americano', 'Coffee', 3.00),
  (3, 'Latte', 'Coffee', 3.50),
  (4, 'Cappuccino', 'Coffee', 3.75),
  (5, 'Mocha', 'Coffee', 4.00),
  (6, 'Chai Tea', 'Tea', 3.25),
  (7, 'Blueberry Muffin', 'Pastry', 2.75),
  (8, 'Bagel', 'Pastry', 2.50);

-- ===============================
-- EMPLOYEES
-- -------------------------------
INSERT INTO employee (employee_id, f_name, l_name, position, hire_date) VALUES
  (1, 'Alice', 'Smith', 'Manager', '2023-01-15'),
  (2, 'Bob', 'Johnson', 'Barista', '2023-02-10'),
  (3, 'Carol', 'Williams', 'Barista', '2023-03-05'),
  (4, 'David', 'Brown', 'Cashier', '2023-04-20'),
  (5, 'Eva', 'Davis', 'Baker', '2023-05-12');

-- ===============================
-- ORDERS (processed by the Cashier)
-- -------------------------------
INSERT INTO orders (order_id, order_date, total_amount, employee_id) VALUES
  (101, '2023-06-01', '7.50', 4),
  (102, '2023-06-01', '5.25', 4),
  (103, '2023-06-02', '9.00', 4),
  (104, '2023-06-02', '3.50', 4),
  (105, '2023-06-03', '4.00', 4),
  (106, '2023-06-03', '12.25', 4),
  (107, '2023-06-04', '6.00', 4),
  (108, '2023-06-04', '8.75', 4),
  (109, '2023-06-05', '10.00', 4),
  (110, '2023-06-05', '7.25', 4);

-- ===============================
-- INVENTORY (ingredients)
-- -------------------------------
INSERT INTO inventory (ingredient_id, ingredient_name, ingredient_cost, ingredient_amount) VALUES
  (1, 'Coffee Beans', '15.00', '10kg'),
  (2, 'Milk', '2.00', '50L'),
  (3, 'Sugar', '1.50', '20kg'),
  (4, 'Tea Leaves', '10.00', '5kg'),
  (5, 'Chocolate Syrup', '5.00', '10L'),
  (6, 'Flour', '3.00', '25kg');

-- ===============================
-- SUPPLIERS (each linked to an ingredient)
-- -------------------------------
INSERT INTO supplier (supplier_id, s_name, s_contact, phone_number, email, ingredient_id) VALUES
  (1, 'Coffee Supply Co', 'John Doe', '555-1234', 'john@coffeesupply.com', 1),
  (2, 'Dairy Best', 'Mary Lee', '555-5678', 'mary@dairybest.com', 2),
  (3, 'Sweet Stuff', 'Sam Sweet', '555-9012', 'sam@sweetstuff.com', 3),
  (4, 'Tea Traders', 'Linda Tea', '555-3456', 'linda@teatraders.com', 4),
  (5, 'Choco Delights', 'Chris Choco', '555-7890', 'chris@chocodelights.com', 5),
  (6, 'Bakers Wholesale', 'Pat Baker', '555-2345', 'pat@bakerswholesale.com', 6);

-- ===============================
-- SHIFTS (for scheduling)
-- -------------------------------
INSERT INTO shifts (shift_id, shift_date, start_time, end_time, shift_type) VALUES
  (1, '2023-06-01', '07:00', '15:00', 'Morning'),
  (2, '2023-06-01', '15:00', '23:00', 'Evening'),
  (3, '2023-06-02', '07:00', '15:00', 'Morning'),
  (4, '2023-06-02', '15:00', '23:00', 'Evening');

-- ===============================
-- SHIFT ASSIGNMENTS (linking employees to shifts)
-- -------------------------------
INSERT INTO shift_assignment (shift_id, employee_id, shift_assignment_id) VALUES
  (1, 2, 'SA1'),  -- Bob (Barista) on morning shift
  (1, 4, 'SA2'),  -- David (Cashier) on morning shift
  (2, 1, 'SA3'),  -- Alice (Manager) on evening shift
  (2, 3, 'SA4'),  -- Carol (Barista) on evening shift
  (3, 2, 'SA5'),  -- Bob on morning shift
  (3, 5, 'SA6'),  -- Eva (Baker) on morning shift
  (4, 1, 'SA7'),  -- Alice on evening shift
  (4, 4, 'SA8'),  -- David on evening shift
  (4, 3, 'SA9');  -- Carol on evening shift

-- ===============================
-- COMPLETED ORDERS (which menu items were sold in each order)
-- -------------------------------
INSERT INTO completed_order (item_id, orders_id, completed_order_id) VALUES
  (1, 101, 'CO101-1'),  -- Order 101: Espresso
  (7, 101, 'CO101-2'),  -- Order 101: Blueberry Muffin
  (2, 102, 'CO102-1'),  -- Order 102: Americano
  (3, 103, 'CO103-1'),  -- Order 103: Latte
  (8, 103, 'CO103-2'),  -- Order 103: Bagel
  (1, 104, 'CO104-1'),  -- Order 104: Espresso
  (6, 105, 'CO105-1'),  -- Order 105: Chai Tea
  (4, 106, 'CO106-1'),  -- Order 106: Cappuccino
  (3, 106, 'CO106-2'),  -- Order 106: Latte
  (2, 106, 'CO106-3'),  -- Order 106: Americano
  (5, 107, 'CO107-1'),  -- Order 107: Mocha
  (8, 108, 'CO108-1'),  -- Order 108: Bagel
  (3, 109, 'CO109-1'),  -- Order 109: Latte
  (4, 109, 'CO109-2'),  -- Order 109: Cappuccino
  (1, 110, 'CO110-1');  -- Order 110: Espresso

-- ===============================
-- RECIPE INGREDIENTS (which ingredients go into each menu item)
-- -------------------------------
INSERT INTO recipe_ingredients (ingredient_id, item_id, recipe_id) VALUES
  (1, 1, 'R1'),             -- Espresso: Coffee Beans
  (1, 2, 'R2'),             -- Americano: Coffee Beans
  (1, 3, 'R3'),             -- Latte: Coffee Beans
  (2, 3, 'R3'),             -- Latte: Milk
  (1, 4, 'R4'),             -- Cappuccino: Coffee Beans
  (2, 4, 'R4'),             -- Cappuccino: Milk
  (3, 4, 'R4'),             -- Cappuccino: Sugar
  (1, 5, 'R5'),             -- Mocha: Coffee Beans
  (2, 5, 'R5'),             -- Mocha: Milk
  (5, 5, 'R5'),             -- Mocha: Chocolate Syrup
  (4, 6, 'R6'),             -- Chai Tea: Tea Leaves
  (2, 6, 'R6'),             -- Chai Tea: Milk
  (6, 7, 'R7'),             -- Blueberry Muffin: Flour
  (3, 7, 'R7'),             -- Blueberry Muffin: Sugar
  (6, 8, 'R8');             -- Bagel: Flour
  
  use ha_group5_crn71552;