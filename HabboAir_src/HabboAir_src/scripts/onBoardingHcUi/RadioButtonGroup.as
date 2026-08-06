package onBoardingHcUi
{
   public class RadioButtonGroup
   {
      private var _selectedAction:Function;
      
      public var buttons:Vector.<RadioButton> = new Vector.<RadioButton>(0);
      
      public function RadioButtonGroup(param1:Function)
      {
         super();
         _selectedAction = param1;
      }
      
      public function get selected() : RadioButton
      {
         for each(var _loc1_ in buttons)
         {
            if(_loc1_.selected)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function performSelectedAction() : void
      {
         _selectedAction();
      }
   }
}

