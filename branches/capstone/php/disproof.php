<?php
class disproof
{

public function get1()
{
        return "1=/=0.999...";
}

public function get2()
{
        return "sqrt(1-1) =/= sqrt(0.999...-1)";
}

public function get3()
{
        return "sqrt(1-1)/sqrt(1-1) =/= sqrt(0.999-1)/sqrt(0.999...-1)";
}

public function get4()
{
        return "sqrt(1-1/sqrt(1-1) =/= sqrt(0.999-1)/sqrt(0.999...-1)";
}

public function get5()
{
        return "DNE =/= 1";
}

}
?>
