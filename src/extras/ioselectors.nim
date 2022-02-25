when defined(windows):
    import ioselectors / [ioselectors_wepoll, base]
    export ioselectors_wepoll, base
else:
    import selectors
    export selectors