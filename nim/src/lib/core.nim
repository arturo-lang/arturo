proc Core_Print*[V,X](v: V, x: X): V =
    #echo "in Core_Print"
    echo v.stringify(quoted=false)
    result = v