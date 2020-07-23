#!/usr/bin/zsh

has_istioctl() {
	type istioctl >& /dev/null
}

install_istioctl() {
	if ! has_istioctl
	then
		local TMPDIR
		TMPDIR=$(mktemp -d)
		(
		cd $TMPDIR
	    curl -sSL https://istio.io/downloadIstio | sh -
	    )
		mv $TMPDIR/bin/istioctl ~/bin
		rm -fr $TMPDIR
	fi
}

post_install_istioctl() {
	if has_istioctl
	then
		TMPDIR=$(mktemp -d)
		istioctl collateral --zsh -o $TMPDIR
		source $TMPDIR/_istioctl
		rm -fr $TMPDIR
	fi
}
