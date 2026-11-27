package cheeseGame.data.customers
{
   import cheeseGame.data.*;
   
   public class CustomerFranco extends CustomerDataFile
   {
      
      public function CustomerFranco()
      {
         super();
      }
      
      override public function initCustomerData() : void
      {
         this.customerName = "Franco";
         this.customerClipName = "Franco";
         this.thumbColor = "yelloworange";
         this.setupOrder();
      }
      
      override public function setupOrder() : void
      {
         var _loc1_:CustomerOrder = new CustomerOrder();
         _loc1_.setBread(FoodData.BREAD_SOURDOUGH);
         _loc1_.setCheese(FoodData.CHEESE_MOZZARELLA);
         _loc1_.setCookType(FoodData.COOK_MEDIUM);
         _loc1_.addToppings(FoodData.TOPPING_BACON,FoodData.TOPPING_TOMATO,FoodData.TOPPING_SAUERKRAUT,FoodData.SAUCE_SOUTHWEST);
         _loc1_.setFries(FoodData.FRIES_REGULAR);
         _loc1_.addFryToppings(FoodData.FRYTOPPING_CHILI,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc1_);
         var _loc2_:CustomerOrder = new CustomerOrder(GameData.MONTH_MAY);
         _loc2_.setBread(FoodData.BREAD_SOURDOUGH);
         _loc2_.setCheese(FoodData.CHEESE_OAXACA);
         _loc2_.setCookType(FoodData.COOK_MEDIUM);
         _loc2_.addToppings(FoodData.SAUCE_GUACAMOLE,FoodData.TOPPING_CHORIZO,FoodData.TOPPING_TOMATO,FoodData.SAUCE_SOUTHWEST);
         _loc2_.setFries(FoodData.FRIES_REGULAR);
         _loc2_.addFryToppings(FoodData.FRYTOPPING_CHILI,FoodData.FRYTOPPING_BACON);
         this.addCustomerOrder(_loc2_);
      }
   }
}

