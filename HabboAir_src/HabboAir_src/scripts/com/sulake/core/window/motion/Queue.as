package com.sulake.core.window.motion
{
   use namespace friend;
   
   public class Queue extends Motion
   {
      private var UnknownVarFromQueue_Motion_1:Motion;
      
      private var UnknownVarFromQueue_Vector_1:Vector.<Motion> = new Vector.<Motion>();
      
      public function Queue(... rest)
      {
         super(!!rest ? Motion(rest[0]).target : null);
         for each(var _loc2_ in rest)
         {
            UnknownVarFromQueue_Vector_1.push(_loc2_);
         }
         UnknownVarFromQueue_Motion_1 = rest[0];
         _complete = UnknownVarFromQueue_Motion_1 == null;
      }
      
      override public function get running() : Boolean
      {
         return _running && UnknownVarFromQueue_Motion_1 ? UnknownVarFromQueue_Motion_1.running : false;
      }
      
      override friend function start() : void
      {
         super.friend::start();
         UnknownVarFromQueue_Motion_1.friend::start();
      }
      
      override friend function update(param1:Number) : void
      {
         super.friend::update(param1);
         if(UnknownVarFromQueue_Motion_1.running)
         {
            UnknownVarFromQueue_Motion_1.friend::update(param1);
         }
      }
      
      override friend function stop() : void
      {
         super.friend::stop();
         UnknownVarFromQueue_Motion_1.friend::stop();
      }
      
      override friend function tick(param1:int) : void
      {
         var _loc2_:int = 0;
         super.friend::tick(param1);
         UnknownVarFromQueue_Motion_1.friend::tick(param1);
         if(UnknownVarFromQueue_Motion_1.complete)
         {
            UnknownVarFromQueue_Motion_1.friend::stop();
            _loc2_ = int(UnknownVarFromQueue_Vector_1.indexOf(UnknownVarFromQueue_Motion_1));
            if(_loc2_ < UnknownVarFromQueue_Vector_1.length - 1)
            {
               UnknownVarFromQueue_Motion_1 = UnknownVarFromQueue_Vector_1[_loc2_ + 1];
               _target = UnknownVarFromQueue_Motion_1.target;
               UnknownVarFromQueue_Motion_1.friend::start();
            }
            else
            {
               _complete = true;
            }
         }
      }
   }
}

