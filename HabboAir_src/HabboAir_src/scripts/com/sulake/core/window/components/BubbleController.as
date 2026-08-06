package com.sulake.core.window.components
{
   import com.sulake.core.window.IWindowModel;
   import com.sulake.core.window.WindowContext;
   import com.sulake.core.window.WindowController;
   import com.sulake.core.window.events.WindowEvent;
   import com.sulake.core.window.utils.PropertyStruct;
   import flash.geom.Rectangle;
   
   public class BubbleController extends FrameController implements IBubbleController
   {
      private static const TAG_POINTER_UP_ELEMENT:String = "_POINTER_UP";
      
      private static const TAG_POINTER_DOWN_ELEMENT:String = "_POINTER_DOWN";
      
      private static const TAG_POINTER_LEFT_ELEMENT:String = "_POINTER_LEFT";
      
      private static const TAG_POINTER_RIGHT_ELEMENT:String = "_POINTER_RIGHT";
      
      private var _direction:String = "down";
      
      private var _pointerOffset:int = 0;
      
      public function BubbleController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindowModel, param8:Function = null, param9:Array = null, param10:Array = null, param11:uint = 0)
      {
         super(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11);
      }
      
      public function get direction() : String
      {
         return _direction;
      }
      
      public function set direction(param1:String) : void
      {
         var _loc2_:IWindowModel = null;
         if(param1 != _direction)
         {
            _loc2_ = getChildByName(param1);
            if(!_loc2_)
            {
               throw new Error("Invalid pointer direction: \"" + param1 + "\"!");
            }
            getChildByName(_direction).visible = false;
            _loc2_.visible = true;
            _direction = param1;
            pointerOffset = _pointerOffset;
         }
      }
      
      public function get pointerOffset() : int
      {
         return _pointerOffset;
      }
      
      public function set pointerOffset(param1:int) : void
      {
         var _loc2_:IWindowModel = getChildByName(_direction);
         if(!_loc2_)
         {
            throw new Error("Invalid pointer direction: \"" + _direction + "\"!");
         }
         if(_direction == "up" || _direction == "down")
         {
            _loc2_.x = width / 2 + param1;
         }
         else
         {
            _loc2_.y = height / 2 + param1;
         }
         _pointerOffset = param1;
      }
      
      override public function update(param1:WindowController, param2:WindowEvent) : Boolean
      {
         var _loc3_:Boolean = super.update(param1,param2);
         if(_pointerOffset != 0)
         {
            if(param1 == this)
            {
               if(param2.type == "WE_RESIZED")
               {
                  pointerOffset = _pointerOffset;
               }
            }
         }
         return _loc3_;
      }
      
      override public function get properties() : Array
      {
         var _loc1_:Array = super.properties;
         _loc1_.push(createProperty("direction",_direction));
         _loc1_.push(createProperty("pointer_offset",_pointerOffset));
         return _loc1_;
      }
      
      override public function set properties(param1:Array) : void
      {
         for each(var _loc2_ in param1)
         {
            switch(_loc2_.key)
            {
               case "direction":
                  direction = _loc2_.value as String;
                  break;
               case "pointer_offset":
                  pointerOffset = _loc2_.value as int;
                  break;
            }
         }
         super.properties = param1;
      }
   }
}

