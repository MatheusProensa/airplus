package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.geom.Rectangle;
   
   public class BoxSizerController extends ContainerController implements IBoxSizerController
   {
      private var UnknownVarFromBoxSizerController_Int_1:int = 5;
      
      private var UnknownVarFromBoxSizerController_Int_2:int = 8;
      
      private var UnknownVarFromBoxSizerController_Int_3:int = 8;
      
      private var UnknownVarFromBoxSizerController_Boolean_1:Boolean = false;
      
      private var _autoRearrange:Boolean = true;
      
      public function BoxSizerController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindowModel, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      override public function update(param1:WindowController, param2:WindowEvent) : Boolean
      {
         switch(param2.type)
         {
            case "WE_CHILD_RELOCATED":
            case "WE_CHILD_REMOVED":
            case "WE_CHILD_ADDED":
            case "WE_CHILD_RESIZED":
            case "WE_RESIZED":
            case "WE_CHILD_VISIBILITY":
               arrangeChildren();
         }
         return super.update(param1,param2);
      }
      
      private function arrangeChildren() : void
      {
         var _loc4_:* = null;
         if(!_autoRearrange)
         {
            return;
         }
         var _loc1_:* = null;
         var _loc3_:int = calculateSpaceForRelatives();
         var _loc2_:int = getRelativeValuesSum();
         if(!UnknownVarFromBoxSizerController_Boolean_1)
         {
            for each(_loc4_ in _children)
            {
               if(_loc4_.visible)
               {
                  if(!_loc1_)
                  {
                     _loc4_.x = UnknownVarFromBoxSizerController_Int_2;
                  }
                  else
                  {
                     _loc4_.x = _loc1_.x + _loc1_.width + UnknownVarFromBoxSizerController_Int_1;
                  }
                  _loc4_.y = UnknownVarFromBoxSizerController_Int_3;
                  if(getRelativeValue(_loc4_) > 0)
                  {
                     _loc4_.width = _loc3_ * getRelativeValue(_loc4_) / _loc2_;
                  }
                  _loc1_ = _loc4_;
               }
            }
         }
         else
         {
            for each(_loc4_ in _children)
            {
               if(_loc4_.visible)
               {
                  if(!_loc1_)
                  {
                     _loc4_.y = UnknownVarFromBoxSizerController_Int_3;
                  }
                  else
                  {
                     _loc4_.y = _loc1_.y + _loc1_.height + UnknownVarFromBoxSizerController_Int_1;
                  }
                  _loc4_.x = UnknownVarFromBoxSizerController_Int_2;
                  if(getRelativeValue(_loc4_) > 0)
                  {
                     _loc4_.height = _loc3_ * getRelativeValue(_loc4_) / _loc2_;
                  }
                  _loc1_ = _loc4_;
               }
            }
         }
      }
      
      private function getRelativeValue(param1:IWindowModel) : int
      {
         var _loc3_:String = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.tags.length)
         {
            _loc3_ = param1.tags[_loc2_];
            if(_loc3_.indexOf("relative") != -1)
            {
               _loc4_ = int(_loc3_.slice(_loc3_.indexOf("(") + 1,_loc3_.indexOf(")")));
               if(_loc4_ < 0)
               {
                  _loc4_ = 0;
               }
               param1.tags.splice(_loc2_,1,"relative(" + _loc4_ + ")");
            }
            _loc2_++;
         }
         return _loc4_;
      }
      
      private function getRelativeValuesSum() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_ in _children)
         {
            if(_loc2_.visible)
            {
               _loc1_ += getRelativeValue(_loc2_);
            }
         }
         return _loc1_;
      }
      
      private function calculateSpaceForRelatives() : int
      {
         var _loc1_:int = UnknownVarFromBoxSizerController_Boolean_1 ? this.height - UnknownVarFromBoxSizerController_Int_3 * 2 : this.width - UnknownVarFromBoxSizerController_Int_2 * 2;
         for each(var _loc2_ in _children)
         {
            if(_loc2_.visible != false)
            {
               if(getRelativeValue(_loc2_) == 0)
               {
                  if(UnknownVarFromBoxSizerController_Boolean_1)
                  {
                     _loc1_ -= _loc2_.height + UnknownVarFromBoxSizerController_Int_1;
                  }
                  else
                  {
                     _loc1_ -= _loc2_.width + UnknownVarFromBoxSizerController_Int_1;
                  }
               }
               else
               {
                  _loc1_ -= UnknownVarFromBoxSizerController_Int_1;
               }
            }
         }
         return _loc1_ + UnknownVarFromBoxSizerController_Int_1;
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(createProperty("spacing",UnknownVarFromBoxSizerController_Int_1));
         _loc1_.push(createProperty("vertical",UnknownVarFromBoxSizerController_Boolean_1));
         _loc1_.push(createProperty("padding_horizontal",UnknownVarFromBoxSizerController_Int_2));
         _loc1_.push(createProperty("padding_vertical",UnknownVarFromBoxSizerController_Int_3));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "spacing":
                  UnknownVarFromBoxSizerController_Int_1 = _loc2_.value as int;
                  break;
               case "padding_horizontal":
                  UnknownVarFromBoxSizerController_Int_2 = _loc2_.value as int;
                  break;
               case "padding_vertical":
                  UnknownVarFromBoxSizerController_Int_3 = _loc2_.value as int;
                  break;
               case "vertical":
                  UnknownVarFromBoxSizerController_Boolean_1 = _loc2_.value as Boolean;
                  break;
            }
         }
         super.properties = param1;
         arrangeChildren();
      }
      
      public function setHorizontalPadding(param1:int) : void
      {
         UnknownVarFromBoxSizerController_Int_2 = param1;
         arrangeChildren();
      }
      
      public function setVerticalPadding(param1:int) : void
      {
         UnknownVarFromBoxSizerController_Int_3 = param1;
         arrangeChildren();
      }
      
      public function setSpacing(param1:int) : void
      {
         UnknownVarFromBoxSizerController_Int_1 = param1;
         arrangeChildren();
      }
      
      public function setVertical(param1:Boolean) : void
      {
         UnknownVarFromBoxSizerController_Boolean_1 = param1;
         arrangeChildren();
      }
      
      public function setAutoRearrange(param1:Boolean) : void
      {
         _autoRearrange = param1;
         if(param1)
         {
            arrangeChildren();
         }
      }
      
      public function getAutoRearrange() : Boolean
      {
         return _autoRearrange;
      }
   }
}

