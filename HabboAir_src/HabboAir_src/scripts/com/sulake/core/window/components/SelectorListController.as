package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.geom.Rectangle;
   
   public class SelectorListController extends SelectorController implements ISelectorListWindow
   {
      protected var _spacing:int = 0;
      
      private var UnknownVarFromSelectorListController_Boolean_1:Boolean = false;
      
      private var _vertical:Boolean;
      
      public function SelectorListController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindowModel, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
         UnknownVarFromSelectorController_Boolean_1 = false;
      }
      
      public function get spacing() : int
      {
         return _spacing;
      }
      
      public function set spacing(param1:int) : void
      {
         _spacing = param1;
         updateSelectableRegion();
      }
      
      override public function update(param1:WindowController, param2:WindowEvent) : Boolean
      {
         if(param2.type == "WE_CHILD_ADDED")
         {
            updateSelectableRegion();
         }
         else if(param2.type == "WE_CHILD_RESIZED")
         {
            updateSelectableRegion();
         }
         else if(param2.type == "WE_CHILD_RELOCATED")
         {
            updateSelectableRegion();
         }
         else if(param2.type == "WE_CHILD_REMOVED")
         {
            updateSelectableRegion();
         }
         return super.update(param1,param2);
      }
      
      private function updateSelectableRegion() : void
      {
         var _loc4_:IWindowModel = null;
         var _loc3_:* = 0;
         if(UnknownVarFromSelectorListController_Boolean_1)
         {
            return;
         }
         UnknownVarFromSelectorListController_Boolean_1 = true;
         var _loc2_:uint = numSelectables;
         var _loc1_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = getSelectableAt(_loc3_);
            if(_vertical)
            {
               _loc4_.y = _loc1_;
               _loc1_ += _loc4_.height + _spacing;
            }
            else
            {
               _loc4_.x = _loc1_;
               _loc1_ += _loc4_.width + _spacing;
            }
            _loc3_++;
         }
         UnknownVarFromSelectorListController_Boolean_1 = false;
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(createProperty("spacing",_spacing));
         _loc1_.push(createProperty("vertical",_vertical));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "spacing":
                  if(_loc2_.value != _spacing)
                  {
                     spacing = _loc2_.value as int;
                  }
                  break;
               case "vertical":
                  if(_loc2_.value != _vertical)
                  {
                     vertical = _loc2_.value as Boolean;
                  }
                  break;
            }
         }
         super.properties = param1;
      }
      
      public function get vertical() : Boolean
      {
         return _vertical;
      }
      
      public function set vertical(param1:Boolean) : void
      {
         _vertical = param1;
         updateSelectableRegion();
      }
   }
}

